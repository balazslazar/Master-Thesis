import PyPDF2
import  re
import glob
import fitz

#your full path of directory
mypath = "/Users/balazslazar/Documents/WU Master/Master Thesis/Books/3"
for file in glob.glob(mypath + "/*.pdf"):
    print(file)
    if file.endswith('.pdf'):

        pdfIn = fitz.open(file)

        for page in pdfIn:
            print(page)
            texts = ["baseline ","baseline document","build ","configuration","configuration control","configuration control board","configruration item","configuration management","configuration management system","control point","document control","engineering change","engineering change proposal","functional baseline","hardware configuration item","interface control","product baseline","program librarian","program support librarian","software change control","software component","software configuration","software configuration auditing","software configuration control","software configuration identification","software configuration item","software configuration management plan","software configuration status accounting","software item","software librarian","software release management","software version control","version ","work product","Software quality","Software testing","software engineering management","Software engineering models","Software engineering methods","Software engineering process","Software requirements"]
            text_instances = [page.search_for(text) for text in texts]

            # coordinates of each word found in PDF-page
            print(text_instances)



    else:
        print("not in format")