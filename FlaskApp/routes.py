from FlaskApp import *
@app.route('/')
@app.route('/login')
def index():
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
    

