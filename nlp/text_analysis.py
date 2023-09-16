from transformers import pipeline
from transformers import AutoModelForSequenceClassification
from transformers import AutoTokenizer, AutoConfig
import numpy as np
from scipy.special import softmax

class TextAnalysis(object):
    """
    Class that analyzes the journal entries of patients. 
    """

    def __init__(self):
        MODEL = f"cardiffnlp/twitter-roberta-base-sentiment-latest"
        self.sentiment_tokenizer = AutoTokenizer.from_pretrained(MODEL)
        self.sentiment_config = AutoConfig.from_pretrained(MODEL)
        # PT
        self.sentiment_model = AutoModelForSequenceClassification.from_pretrained(MODEL)

        self.summarizer = pipeline("summarization", model="facebook/bart-large-cnn")

    # Preprocess text (username and link placeholders)
    def preprocess(text):
        new_text = []
        for t in text.split(" "):
            t = '@user' if t.startswith('@') and len(t) > 1 else t
            t = 'http' if t.startswith('http') else t
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
        sentiment_scores : dict
            The softmax probabilities for the journal entry to be classified with a particular sentiment {negative, neutral, positive}.
        """
        #model.save_pretrained(MODEL)

        # pipe = pipeline('sentiment-analysis')
        text = TextAnalysis.preprocess(journal_entry) # THIS IS THE TEXT THAT PROMPTS THE USER
        encoded_input = self.sentiment_tokenizer(text, return_tensors='pt')
        output = self.sentiment_model(**encoded_input)
        scores = output[0][0].detach().numpy()
        scores = softmax(scores)

        # Print labels and scores
        # ranking = np.argsort(scores)
        # ranking = ranking[::-1]
        sentiment_scores = {} # THIS IS THE DICTIONARY WITH THE SENTIMENT SCORES
        for i in range(scores.shape[0]):
            l = self.sentiment_config.id2label[i]
            s = scores[i]
            sentiment_scores[f'{l}'] = np.round(float(s), 4)

        return sentiment_scores
        

    def summarize(self, journal_entry:str):
        """
        Summarizes a body of text to include some of the main points and sentiments.

        Parameters
        ----------
        journal_entry : str, required
            The patient's journal entry that will be summarized.

        Returns
        -------
        summarized_text : str
            Summary of the patient's journal entry.
        """

        summarized_text = self.summarizer(journal_entry, max_length=200, min_length=30, do_sample=False)

        return summarized_text[0]['summary_text']