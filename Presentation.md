Next Word Prediction
========================================================
author: Claus Bo Hansen
date: 2019-12-04
autosize: true

*An introduction to assisted text entry, predicting what the user wants to enter next.*


The Business Case
========================================================

Users input text on a range of devices all day long.  
In order to make your application stand out, you will (among other things) need a state-of-art algorithm to
assist the user when entering text.  
Assisted text entry will speed up text entry and make a better user experience.


Under The Hood
========================================================

Next Word Prediction is based on large amounts of text, which has been analyzed and reduced to an efficient
database, which can be used for fast prediction of next word in the text.  

The database consists of uni-, bi-, tri- and quadgrams (one to four word strings) along with metrics to
calculate likelyhood that any given string will be entered. A scoring function factors in the source of the
string (swhich n-gram class), the number of occurences in corpus used for training the system as well as number
of matches coming from each individual n-gram class.


Instructions For Use
========================================================

1. Open <https://clausbohansen.shinyapps.io/PredictNextWord/> in your browser

2. Start typing in a text in the input box displayed under "Enter beginning of string"

3. The prediction of next word will by dynamically updated next to the input box.


**NOTE:**  
The system will predict the word the are currently entering, until you press space.  
After pressing space, it will predict the next word.


Examples
========================================================

In the examples below, **do not** enter the quotation marks. (")

### Next word prediction

*Enter:*  
**"I love "**  
*Result:*  
**you**

*Enter:*  
**"i want to "**  
*Result:*  
**be**



### Current word prediction

*Enter:*  
**"what are you d"**  
*Result:*  
**doing**

*Enter:*  
**"he is g"**  
*Result:*  
**going**




