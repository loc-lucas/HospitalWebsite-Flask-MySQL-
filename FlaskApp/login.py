from FlaskApp import *
from .adminProc import *

@app.route('/procLog', methods=['GET', 'POST'])
def procLog():    
    usr_id = int(request.form['id']) 
    usr_pwd = request.form['pwd']    
    for item in session['usrList']:
        print(item)
        if usr_id == item[0] and  usr_pwd == item[1] and item[2] == 'admin':
            return redirect(url_for('admin'))
        elif usr_id == item[0] and  usr_pwd == item[1] and item[2] == 'doctor':
            session['id'] = usr_id
            return redirect(url_for('doctor'))
        elif usr_id == item[0] and  usr_pwd == item[1] and item[2] == 'patient':
            session['id'] = usr_id
            return redirect(url_for('patient'))                       
    return 'Cant find any'