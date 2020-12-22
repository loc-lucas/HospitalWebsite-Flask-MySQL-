from FlaskApp import *
# import datetime
@app.route('/docProc', methods=['POST'])
def docProc():            
    dates = request.form['dates'] 
    if dates == '': 
        session['msg'] = 'Please choose date'
        return redirect(url_for('rerenderAdmin'))

    shift = request.form['shift']
    depart = request.form['depart']                

    if shift == 'Morning': shift = 'A'
    elif shift == 'Afternoon': shift = 'B'
    
    if shift != 'Both' and depart != 'All':
        cursor.callproc('getDocAtSpecificDSD', (dates, depart, shift))
    elif shift == 'Both' and depart != 'All':
        cursor.callproc('getDocICDateDepart', (dates, depart))    
    elif shift != 'Both' and depart == 'All':
        cursor.callproc('getDocICPerDate', (dates, shift))
    else:         
        cursor.callproc('getDocICDate', (dates,))

    data = cursor.fetchall()
    session['docData'] = data
    session['tab'] = "doc"
    return redirect(url_for('rerenderAdmin'))

@app.route('/patProc', methods=['POST'])
def patProc():            
    state = request.form['state']          
    shift = request.form['shift']
    dates = request.form['dates'] 
    depart = request.form['depart']  

    if shift == 'Morning': shift = 'A'
    elif shift == 'Afternoon': shift = 'B'

    if state == 'Both' and shift != 'Both' and depart != 'All':
        cursor.callproc('countPatPerDateDepart', (dates, depart, shift))
    elif state == 'Boarded' and shift != 'Both' and depart != 'All':
        cursor.callproc('countBPatPerDateDepart', (dates, depart, shift))
    elif state == 'Out' and shift != 'Both' and depart != 'All':
        cursor.callproc('countOPatPerDateDepart', (dates, depart, shift))   
    elif state == 'Both' and shift != 'Both' and depart == 'All':
        cursor.callproc('countBPatPerDate', (dates, shift))            

    data = cursor.fetchall()    
    session['patData'] = data
    session['tab'] = "pat"
    return redirect(url_for('rerenderAdmin'))    

@app.route('/testProc', methods=['POST'])
def testProc():            
    dates = request.form['dates'] 
    depart = request.form['depart']            
    
    if depart != 'All':
        cursor.callproc('countTestDateDepart', (dates, depart))
    else:
        cursor.callproc('countTestDate', (dates,))

    data = cursor.fetchall()
    session['testData'] = data
    session['tab'] = "test"
    return redirect(url_for('rerenderAdmin'))

@app.route('/addDoc', methods=['POST'])
def addDoc():            
    ssn = request.form['ssn']
    lname = request.form['lname']
    minit = request.form['minit']
    fname = request.form['fname']
    bdate = request.form['bdate']
    addr = request.form['addr']
    depart = request.form['depart']  
    cursor.callproc('addDoctor', (ssn, lname, minit, fname, bdate, addr, depart))
    conn.commit()    
    session['tab'] = "create"
    return redirect(url_for('rerenderAdmin'))

@app.route('/admin/proc', methods=['GET', 'POST'])
def rerenderAdmin():    
    return render_template('admin.html', departList=session['departList'], msg=session['msg'],
    docData=session['docData'], patData=session['patData'], testData=session['testData'], tabidx=session['tab'])