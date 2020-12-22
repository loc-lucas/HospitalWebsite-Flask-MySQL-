from FlaskApp import *

def initPatient():
    pID = session['id']

    cursor.execute('select * from PATIENT WHERE ID = %s', (pID,))
    pat = cursor.fetchone()

    # from latest examination
    cursor.callproc('getMedLatest', (pID,))
    med = cursor.fetchall()

    cursor.callproc('getDocLatest', (pID,))
    doc = cursor.fetchall()

    cursor.callproc('getDietLatest', (pID,))
    diet = cursor.fetchall()

    cursor.callproc('getTestResLatest', (pID,))
    test = cursor.fetchall()

    cursor.callproc('getFTestResLatest', (pID,))
    ftest = cursor.fetchall()

    # from all examination
    cursor.callproc('getMedAll', (pID,))
    medList = cursor.fetchall()

    cursor.callproc('getAllTest', (pID,))
    testList = cursor.fetchall()

    cursor.callproc('getAllTest', (pID,))
    ftestList = cursor.fetchall()

    cursor.callproc('getAllAbnorTest', (pID,))
    abList = cursor.fetchall()

    cursor.callproc('getAllDoc', (pID,))
    docList = cursor.fetchall()

    cursor.callproc('getAllDiet', (pID,))
    dietList = cursor.fetchall()

    return render_template('patient.html', pat=pat, med=med, doc=doc, diet=diet, test=test, ftest=ftest,
    medList=medList, testList=testList, ftestList=ftestList, docList=docList, dietList=dietList, abList=abList)
    
@app.route('/patient/updateInfo', methods=['POST'])
def updateInfo():
    pID = session['ssn']
    insurID = request.form['insurID']
    lname = request.form['lname']
    minit = request.form['minit']
    fname = request.form['fname']
    bdate = request.form['bdates']    
    addr = request.form['addr']

    cursor.callproc('updateInfo', (pID, insurID, lname, minit, fname, bdate, addr))
    conn.commit()

@app.route('/patient/proc', methods=['GET', 'POST'])
def rerenderPatient():    
    return render_template('patient.html', departList=session['departList'], diet=session['diet'],
    doc=session['doc'], test=session['test'], med=session['med'])