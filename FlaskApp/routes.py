from FlaskApp import *
from .login import *
@app.route('/')
@app.route('/login')
def index():
    # fetch doctor data
    cursor.execute('SELECT * FROM DOCTOR;')
    docList = cursor.fetchall()
    session['docList'] = docList

    # fetch patient data
    cursor.execute('SELECT * FROM PATIENT;')
    patList = cursor.fetchall()
    session['patList'] = patList

    # fetch test data
    cursor.execute('SELECT * FROM TESTLIST;')
    testList = cursor.fetchall()
    session['testList'] = testList

    # fetch film test data
    cursor.execute('SELECT * FROM PATIENT;')
    filmList = cursor.fetchall()
    session['filmList'] = filmList
    
    return render_template('index.html') ## put homepage here

@app.route('/admin')
def admin():
    return render_template('admin.html')

@app.route('/patient')
def patient():
    return render_template('patient.html')

@app.route('/doctor')
def doctor():
    return render_template('doctor.html')
    



