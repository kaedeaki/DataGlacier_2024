import numpy as np
from flask import Flask, request, render_template
import pickle

app = Flask(__name__)
model = pickle.load(open('model.pkl', 'rb'))

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/predict',methods=['POST'])
def predict():
    '''
    For rendering results on HTML GUI
    '''
    form_data = request.form

    # conver strings to int or float as need
    applicant_income = float(form_data['applicantIncome'])
    coapplicant_income = float(form_data['coapplicantIncome'])
    loan_amount = float(form_data['loanamount'])
    loan_amount_term = float(form_data['loanamountterm'])
    credit_history = 1 if form_data['credit_history'] == 'Yes' else 0


    #One-Hot encoding
    married = 1 if form_data['married'] == 'Yes' else 0  # married_yes -> 1 
    dependents = form_data['dependents']
    dependents_value = 3 if dependents == '3+' else int(dependents)
    education = 1 if form_data['education'] == 'Yes' else 0  # education_yes -> 1
    self_employed = 1 if form_data['self_employed'] == 'Yes' else 0  # self_employed_yes -> 1

    gender_male = 1 if form_data['gender_male'] == 'Yes' else 0  # Gender Male -> 1
    gender_female = 1 if form_data['gender_male'] == 'No' else 0  # Gender Female -> 1

    # encoding for Property Area
    property_area = form_data['property_area']
    rural = 1 if property_area == 'Rural' else 0
    semiurban = 1 if property_area == 'Semiurban' else 0
    urban = 1 if property_area == 'Urban' else 0

    # put array the future characteristics
    final_features = np.array([
        applicant_income,
        coapplicant_income,
        loan_amount,
        loan_amount_term,
        credit_history,
        married,
        dependents_value,
        education,
        self_employed,
        gender_male,
        gender_female,
        rural,
        semiurban,
        urban
    ]).reshape(1, -1)


    #predict implimentaion
    prediction = model.predict(final_features)

    output = "Yes" if prediction[0] == 1 else "No"

    return render_template('index.html', prediction_text='Loan Acceptance {}'.format(output))

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)