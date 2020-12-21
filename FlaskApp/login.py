from FlaskApp import *
from .adminProc import *
@app.route('/procLog', methods=['GET', 'POST'])
def procLog():
    print(request.form['id'], request.form['pwd'])        
    return redirect(url_for('admin'))