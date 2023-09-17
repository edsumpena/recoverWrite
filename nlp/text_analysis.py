from transformers import AutoTokenizer, AutoConfig, RobertaForSequenceClassification
import numpy as np
from scipy.special import softmax

class TextAnalysis(object):
    """
    Class that analyzes the journal entries of patients. 
    """

    def __init__(self):
        SENTIMENT_MODEL = f"cardiffnlp/twitter-roberta-base-sentiment-latest"
        self.sentiment_tokenizer = AutoTokenizer.from_pretrained(SENTIMENT_MODEL)
        self.sentiment_config = AutoConfig.from_pretrained(SENTIMENT_MODEL) # 0: negative, 1: neutral, 2: positive
        # PT
        self.sentiment_model = RobertaForSequenceClassification.from_pretrained(SENTIMENT_MODEL)

        # SUMMARIZER_MODEL = "sshleifer/distilbart-cnn-12-6"
        # self.summarizer_tokenizer = AutoTokenizer.from_pretrained(SUMMARIZER_MODEL)
        # self.summarizer_model = BartForConditionalGeneration.from_pretrained(SUMMARIZER_MODEL)

    # Preprocess text (username and link placeholders)
    def preprocess(text):
        new_text = []
        for t in text.split(" "):
            t = '@user' if t.startswith('@') and len(t) > 1 else t
            t = 'http' if t.startswith('http') else t
            t = t.replace('\n', '').replace(' ', '')
            new_text.append(t)
        return " ".join(new_text)
    
    def sentiment_analysis(self, journal_entry:str):
        """Takes in a body of text and identifies the probability of such an entry being negative, netural, or positive sentiment.
        
        Parameters
        ----------
        journal_entry : str, required
            The journal entry of the patient that will undergo sentiment analyses.

        Returns
        -------
        sentences : list
            All the sentences of the journal entry.

        sentiment_per_sentence : list
            The sentiment score (negative, neutral, positive) of each sentence in the journal entry.
        """
        text = TextAnalysis.preprocess(journal_entry) # THIS IS THE TEXT THAT PROMPTS THE USER
        sentences = text.split(".")
        sentiment_per_sentence = []

        for sentence in sentences:
            encoded_input = self.sentiment_tokenizer(sentence, return_tensors='pt')
            output = self.sentiment_model(**encoded_input)
            scores = output[0][0].detach().numpy()
            scores = softmax(scores)
            sentiment_per_sentence.append(scores)

        sentences = np.asarray(sentences)
        sentiment_per_sentence = np.asarray(sentiment_per_sentence)

        return sentences, sentiment_per_sentence
        
    def get_sentiment_scores(self, journal_entry):
        """Get the overall sentiment score of the entire journal entry."""
        _, sentiment_per_sentence = self.sentiment_analysis(journal_entry)

        sentiment_scores = {} # THIS IS THE DICTIONARY WITH THE SENTIMENT SCORES
        for i in range(sentiment_per_sentence.shape[1]):
            l = self.sentiment_config.id2label[i]
            s = sentiment_per_sentence[:, i].mean()
            sentiment_scores[f'{l}'] = np.round(float(s), 4)
        
        return sentiment_scores

    def get_summary(self, journal_entry:str):
        """
        Summarizes a body of text to include some of the main points and sentiments.

        Parameters
        ----------
        journal_entry : str, required
            The patient's journal entry that will be summarized.

        Returns
        -------
        summary : str
            Summary of the patient's journal entry (ie top emotionally positive and negative sentences).
        """

        sentences, sentiment_per_sentence = self.sentiment_analysis(journal_entry)

        sorted_negative_sentence_idxs = np.argsort(sentiment_per_sentence[:, 0])
        sorted_positive_sentence_idxs = np.argsort(sentiment_per_sentence[:, 2])
        
        summary = {}

        if len(sentences) > 3:
            summary['Negative Sentences'] = sentences[sorted_negative_sentence_idxs[-1:]]
            summary['Positive Sentences'] = sentences[sorted_positive_sentence_idxs[-1:]]
        else:
            summary['Negative Sentences'] = sentences[sorted_negative_sentence_idxs[-2:]]
            summary['Positive Sentences'] = sentences[sorted_positive_sentence_idxs[-2:]]
        
        return summary

    def create_flask_dict(self, journal_entry):
        """Create a dictionary that will be used for the flask backend"""
        sentiment_score = self.get_sentiment_scores(journal_entry)
        summary = self.get_summary(journal_entry)

        flask_dict = {}
        flask_dict['Sentiment Scores'] = sentiment_score
        flask_dict['Positive Sentences'] = summary['Positive Sentences']
        flask_dict['Negative Sentences'] = summary['Negative Sentences']

        return flask_dict