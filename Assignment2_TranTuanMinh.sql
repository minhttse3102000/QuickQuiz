create database Assigment2_TranTuanMinh
go
use Assigment2_TranTuanMinh
go

create table tblRole (
	roleID varchar(10) primary key not null,
	roleName nvarchar(50),
	status bit 
)
create table tblUsers (
	email varchar(30) primary key not null,
	fullName nvarchar(50),
	password varchar(100),
	roleID varchar(10) foreign key references tblRole(roleID),
	status bit 
)
create table tblSubjects (
	subjectID varchar(30) primary key not null,
	subjectName nvarchar(50),
	timeQuiz int,
    numberQuestion int,
	status bit 
)

create table tblQuestions (
	questionID varchar(30) primary key not null,
	question_content nvarchar(150),
	createDate date,
	subjectID varchar(30) foreign key references tblSubjects(subjectID),
	status bit 
)

create table tblAnswers (
	answerID int IDENTITY (1,1) primary key not null,
	answer_content nvarchar(150),
	questionID varchar(30) foreign key references tblQuestions(questionID),
	answer_correct bit,
	status bit 
)

create table tblQuizs (
	quizID varchar(30) primary key not null,
	email varchar(30) foreign key references tblUsers(email),
	subjectID varchar(30) foreign key references tblSubjects(subjectID),
	totalMark float check(totalMark >=0),
	finishedQuizTime datetime,
	status bit
)

create table tblQuizDetail (
	detailID int IDENTITY (1,1) primary key not null,
	quizID varchar(30) foreign key references tblQuizs(quizID),
	questionID varchar(30) foreign key references tblQuestions(questionID),
	selectedAnswer int,
	result bit,
	status bit 
)


INSERT INTO tblRole
values('AD','Admin',1)
INSERT INTO tblRole
values('US','Student',1)

INSERT INTO tblUsers
values('admin@fpt.edu.vn',N'admin name','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','AD',1)
INSERT INTO tblUsers
values('test@fpt.edu.vn',N'Tester','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','US',1)
INSERT INTO tblUsers
values('minhttse140690@fpt.edu.vn',N'Minh nè','6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b','US',1)

INSERT INTO tblSubjects
values('PRJ311','Java Desktop',15,10,1)
INSERT INTO tblSubjects
values('PRJ321','Java Web',15,10,1)
INSERT INTO tblSubjects
values('PRO123','Java OOP',15,10,1)

INSERT INTO tblQuestions
values('QE1','Which of the following classes is a heavyweight component?','2/5/2021','PRJ311',1)
INSERT INTO tblAnswers
values('JButton','QE1',0,1)
INSERT INTO tblAnswers
values('JTextField','QE1',0,1)
INSERT INTO tblAnswers
values('JPanel','QE1',0,1)
INSERT INTO tblAnswers
values('JFrame','QE1',1,1)

INSERT INTO tblQuestions
values('QE2','Which component cannot be added to a container?','2/5/2021','PRJ311',1)
INSERT INTO tblAnswers
values('JPanel','QE2',0,1)
INSERT INTO tblAnswers
values('JButton','QE2',0,1)
INSERT INTO tblAnswers
values('JFrame','QE2',1,1)
INSERT INTO tblAnswers
values('JComponent','QE2',0,1)

INSERT INTO tblQuestions
values('QE3','What is best to describe the relationship between a container and a SWing GUI object in the container?','2/5/2021','PRJ311',1)
INSERT INTO tblAnswers
values('Association','QE3',0,1)
INSERT INTO tblAnswers
values('Aggregation','QE3',0,1)
INSERT INTO tblAnswers
values('Composition','QE3',1,1)
INSERT INTO tblAnswers
values('Inheritance','QE3',0,1)

INSERT INTO tblQuestions
values('QE4','What layout manager should you use so that every component occupies the same size in the container?','2/5/2021','PRJ311',1)
INSERT INTO tblAnswers
values('a FlowLayout','QE4',0,1)
INSERT INTO tblAnswers
values('a GridLayout','QE4',1,1)
INSERT INTO tblAnswers
values('a BorderLayout','QE4',0,1)
INSERT INTO tblAnswers
values('any layout','QE4',0,1)

INSERT INTO tblQuestions
values('QE5','What should you use to position a Button within an application Frame so that the size of the Button is NOT affected by the Frame size?','2/5/2021','PRJ311',1)
INSERT INTO tblAnswers
values('a FlowLayout','QE5',1,1)
INSERT INTO tblAnswers
values('a GridLayout','QE5',0,1)
INSERT INTO tblAnswers
values('the East or West area of a BorderLayout','QE5',0,1)
INSERT INTO tblAnswers
values('the North or South area of a BorderLayout','QE5',0,1)

INSERT INTO tblQuestions
values('QE6','Suppose a JFrame uses the GridLayout(0, 2). If you add six buttons to the frame, how many columns are displayed?','2/5/2021','PRJ311',1)
INSERT INTO tblAnswers
values('1','QE6',0,1)
INSERT INTO tblAnswers
values('2','QE6',1,1)
INSERT INTO tblAnswers
values('3','QE6',0,1)
INSERT INTO tblAnswers
values('4','QE6',0,1)

INSERT INTO tblQuestions
values('QE7','The default layout out of a JPanel is __________.','2/5/2021','PRJ311',1)
INSERT INTO tblAnswers
values('FlowLayout','QE7',1,1)
INSERT INTO tblAnswers
values('GridLayout','QE7',0,1)
INSERT INTO tblAnswers
values('BorderLayout','QE7',0,1)
INSERT INTO tblAnswers
values('None','QE7',0,1)

INSERT INTO tblQuestions
values('QE8','To add a component c to a JPanel p, use _________.','2/5/2021','PRJ311',1)
INSERT INTO tblAnswers
values('p.add(c)','QE8',1,1)
INSERT INTO tblAnswers
values('p.getContentPane(c)','QE8',0,1)
INSERT INTO tblAnswers
values('p.insert(c)','QE8',0,1)
INSERT INTO tblAnswers
values('p.append(c)','QE8',0,1)

INSERT INTO tblQuestions
values('QE9','Which color is the darkest?','2/5/2021','PRJ311',1)
INSERT INTO tblAnswers
values('new Color(0, 0, 0)','QE9',1,1)
INSERT INTO tblAnswers
values('new Color(10, 0, 0)','QE9',0,1)
INSERT INTO tblAnswers
values('new Color(20, 0, 0)','QE9',0,1)
INSERT INTO tblAnswers
values('f.setForeGround(Color.yellow)','QE9',0,1)

INSERT INTO tblQuestions
values('QE10','To specify a font to be bold and italic, use the font style value _________','2/5/2021','PRJ311',1)
INSERT INTO tblAnswers
values('Font.PLAIN','QE10',0,1)
INSERT INTO tblAnswers
values('Font.BOLD','QE10',0,1)
INSERT INTO tblAnswers
values('Font.ITALIC','QE10',0,1)
INSERT INTO tblAnswers
values('Font.BOLD + Font.ITALIC','QE10',1,1)

INSERT INTO tblQuestions
values('QE11','The method __________ gets the text (or caption) of the button jbt.','2/5/2021','PRJ311',1)
INSERT INTO tblAnswers
values('jbt.text()','QE11',0,1)
INSERT INTO tblAnswers
values('jbt.getText()','QE11',1,1)
INSERT INTO tblAnswers
values('jbt.findText()','QE11',0,1)
INSERT INTO tblAnswers
values('jbt.retrieveText().','QE11',0,1)

INSERT INTO tblQuestions
values('QE12','The method __________ specifies that the text is placed on the right of the icon in the button jbt.','2/5/2021','PRJ311',1)
INSERT INTO tblAnswers
values('jbt.setVerticalTextPosition(JButton.LEFT)','QE12',0,1)
INSERT INTO tblAnswers
values('jbt.setHorizontalTextPosition(JButton.LEFT)','QE12',0,1)
INSERT INTO tblAnswers
values('jbt.setHorizontalTextPosition(JButton.RIGHT)','QE12',1,1)
INSERT INTO tblAnswers
values('jbt.setHorizontalAlignment(JButton.LEFT)','QE12',0,1)

INSERT INTO tblQuestions
values('QE13','_________ checks whether the JCheckBox jchk is selected.','2/5/2021','PRJ311',1)
INSERT INTO tblAnswers
values('jchk.getSelected()','QE13',0,1)
INSERT INTO tblAnswers
values('jchk.selected()','QE13',0,1)
INSERT INTO tblAnswers
values('jchk.isSelected().','QE13',1,1)
INSERT INTO tblAnswers
values('jchk.select()','QE13',0,1)

INSERT INTO tblQuestions
values('QE14','Which of the following are valid methods on the label jlbl?','2/5/2021','PRJ311',1)
INSERT INTO tblAnswers
values('jlbl.setMnemonic("A");','QE14',0,1)
INSERT INTO tblAnswers
values('jlbl.setMnemonic(A);','QE14',0,1)
INSERT INTO tblAnswers
values('jlbl.setIconTextGap(50);','QE14',1,1)
INSERT INTO tblAnswers
values('jlbl.setTextGap(50);','QE14',0,1)

INSERT INTO tblQuestions
values('QE15','___________ can be used to enter or display a string.','2/5/2021','PRJ311',1)
INSERT INTO tblAnswers
values('A label','QE15',0,1)
INSERT INTO tblAnswers
values('A button','QE15',0,1)
INSERT INTO tblAnswers
values('A check box','QE15',0,1)
INSERT INTO tblAnswers
values('A text field','QE15',1,1)

INSERT INTO tblQuestions
values('QE16','Clicking a JButton object generates __________ events.','2/5/2021','PRJ311',1)
INSERT INTO tblAnswers
values('ActionEvent','QE16',1,1)
INSERT INTO tblAnswers
values('ItemEvent','QE16',0,1)
INSERT INTO tblAnswers
values('ComponentEvent','QE16',0,1)
INSERT INTO tblAnswers
values('ContainerEvent','QE16',0,1)

INSERT INTO tblQuestions
values('QE17','To wrap a line in a text area jta, invoke ____________.','2/5/2021','PRJ311',1)
INSERT INTO tblAnswers
values('jta.setLineWrap(false)','QE17',0,1)
INSERT INTO tblAnswers
values('jta.setLineWrap(true)','QE17',1,1)
INSERT INTO tblAnswers
values('jta.WrapLine()','QE17',0,1)
INSERT INTO tblAnswers
values('jta.wrapText()','QE17',0,1)

INSERT INTO tblQuestions
values('QE18','How many items can be added into a JComboBox object?','2/5/2021','PRJ311',1)
INSERT INTO tblAnswers
values('0','QE18',0,1)
INSERT INTO tblAnswers
values('1','QE18',0,1)
INSERT INTO tblAnswers
values('2','QE18',0,1)
INSERT INTO tblAnswers
values('Unlimited','QE18',1,1)

INSERT INTO tblQuestions
values('QE19','____________ is a component that enables the user to choose a single value or multiple values.','2/5/2021','PRJ311',1)
INSERT INTO tblAnswers
values('A text field','QE19',0,1)
INSERT INTO tblAnswers
values('A combo box','QE19',0,1)
INSERT INTO tblAnswers
values('A list','QE19',1,1)
INSERT INTO tblAnswers
values('A label','QE19',0,1)

INSERT INTO tblQuestions
values('QE20','Clicking a JList object generates __________ events.','2/5/2021','PRJ311',1)
INSERT INTO tblAnswers
values('ActionEvent and ItemEvent','QE20',1,1)
INSERT INTO tblAnswers
values('ItemEvent and ComponentEvent','QE20',0,1)
INSERT INTO tblAnswers
values('ComponentEvent and ContainerEvent','QE20',0,1)
INSERT INTO tblAnswers
values('ActionEvent and ContainerEvent','QE20',0,1)

INSERT INTO tblQuestions
values('QE21','Which is correct sequence for a JDBC execution?','2/5/2021','PRJ321',1)
INSERT INTO tblAnswers
values('Connection -> Load Driver -> Statement -> ResultSet','QE21',0,1)
INSERT INTO tblAnswers
values('Load Driver -> Statement -> ResultSet -> Connection','QE21',0,1)
INSERT INTO tblAnswers
values('Load Driver -> Connection -> Statement -> ResultSet','QE21',1,1)
INSERT INTO tblAnswers
values('Statement -> Connection -> ResultSet -> Load Driver','QE21',0,1)

INSERT INTO tblQuestions
values('QE22','To send text outptut in a response, the following method of HttpServletResponse may be used to get the appropriate Writer/Stream object.','2/5/2021','PRJ321',1)
INSERT INTO tblAnswers
values('getOutputStream','QE22',0,1)
INSERT INTO tblAnswers
values('getBinaryStream','QE22',0,1)
INSERT INTO tblAnswers
values('getWriter','QE22',1,1)
INSERT INTO tblAnswers
values('getStream','QE22',0,1)

INSERT INTO tblQuestions
values('QE23','______ is a set of java API for executing SQL statements.','2/5/2021','PRJ321',1)
INSERT INTO tblAnswers
values('JDBC','QE23',1,1)
INSERT INTO tblAnswers
values('JAVADB','QE23',0,1)
INSERT INTO tblAnswers
values('ODBC','QE23',0,1)
INSERT INTO tblAnswers
values('None of the other choices','QE23',0,1)

INSERT INTO tblQuestions
values('QE24','JDBC supports ______ and ______ models.','2/5/2021','PRJ321',1)
INSERT INTO tblAnswers
values('Three-tier and four-tier','QE24',0,1)
INSERT INTO tblAnswers
values('Two-tier and three-tier','QE24',1,1)
INSERT INTO tblAnswers
values('None of the other choices','QE24',0,1)
INSERT INTO tblAnswers
values('Single-tier and two-tier','QE24',0,1)

INSERT INTO tblQuestions
values('QE25','URL referring to databases use the form:','2/5/2021','PRJ321',1)
INSERT INTO tblAnswers
values('protocol:subprotocol:datasoursename','QE25',0,1)
INSERT INTO tblAnswers
values('jdbc:odbc:datasoursename','QE25',1,1)
INSERT INTO tblAnswers
values('protocol:datasoursename','QE25',0,1)
INSERT INTO tblAnswers
values('jdbc:datasoursename','QE25',0,1)

INSERT INTO tblQuestions
values('QE26','The ______ class is the primary class that has the driver information.','2/5/2021','PRJ321',1)
INSERT INTO tblAnswers
values('None of the other choices','QE26',0,1)
INSERT INTO tblAnswers
values('Driver','QE26',0,1)
INSERT INTO tblAnswers
values('DriverManager','QE26',1,1)
INSERT INTO tblAnswers
values('ODBCDriver','QE26',0,1)

INSERT INTO tblQuestions
values('QE27','Name the method defined in the HttpServletResponse class that may be used to set the content type. Select the one correct answer.','2/5/2021','PRJ321',1)
INSERT INTO tblAnswers
values('setType','QE27',0,1)
INSERT INTO tblAnswers
values('setContent','QE27',1,1)
INSERT INTO tblAnswers
values('setContentType','QE27',0,1)
INSERT INTO tblAnswers
values('setResponseContentType','QE27',0,1)

INSERT INTO tblQuestions
values('QE28','The sendError method defined in the HttpServlet class is equivalent to invoking the setStatus method with the following parameter.','2/5/2021','PRJ321',1)
INSERT INTO tblAnswers
values('SC_OK','QE28',0,1)
INSERT INTO tblAnswers
values('SC_MOVED_TEMPORARILY','QE28',0,1)
INSERT INTO tblAnswers
values('SC_NOT_FOUND','QE28',1,1)
INSERT INTO tblAnswers
values('ESC_BAD_REQUEST','QE28',0,1)

INSERT INTO tblQuestions
values('QE29','Which of the following statements are correct about the status of the Http response. Select the one correct answer.','2/5/2021','PRJ321',1)
INSERT INTO tblAnswers
values('A status of 200 to 299 signifies that the request was successful.','QE29',1,1)
INSERT INTO tblAnswers
values('A status of 300 to 399 are informational messages.','QE29',0,1)
INSERT INTO tblAnswers
values('A status of 400 to 499 indicates an error in the server.','QE29',0,1)
INSERT INTO tblAnswers
values('A status of 500 to 599 indicates an error in the client.','QE29',0,1)

INSERT INTO tblQuestions
values('QE30','Which HTTP method gets invoked when a user clicks on a link? Select the one correct answer.','2/5/2021','PRJ321',1)
INSERT INTO tblAnswers
values('GET method','QE30',1,1)
INSERT INTO tblAnswers
values('POST method','QE30',0,1)
INSERT INTO tblAnswers
values('HEAD method','QE30',0,1)
INSERT INTO tblAnswers
values('PUT method','QE30',0,1)

INSERT INTO tblQuestions
values('QE31','Name the http method used to send resources to the server. Select the one correct answer.','2/5/2021','PRJ321',1)
INSERT INTO tblAnswers
values('FTP method','QE31',0,1)
INSERT INTO tblAnswers
values('PUT method','QE31',1,1)
INSERT INTO tblAnswers
values('WRITE method','QE31',0,1)
INSERT INTO tblAnswers
values('COPY method','QE31',0,1)

INSERT INTO tblQuestions
values('QE32','Name the http method that sends the same response as the request. Select the one correct answer.','2/5/2021','PRJ321',1)
INSERT INTO tblAnswers
values('TRACE method','QE32',1,1)
INSERT INTO tblAnswers
values('DEBUG method','QE32',0,1)
INSERT INTO tblAnswers
values('OPTIONS method','QE32',0,1)
INSERT INTO tblAnswers
values('HEAD method','QE32',0,1)

INSERT INTO tblQuestions
values('QE33','Which three digit error codes represent an error in request from client? Select the one correct answer.','2/5/2021','PRJ321',1)
INSERT INTO tblAnswers
values('Codes starting from 200','QE33',0,1)
INSERT INTO tblAnswers
values('Codes starting from 300','QE33',0,1)
INSERT INTO tblAnswers
values('Codes starting from 400','QE33',1,1)
INSERT INTO tblAnswers
values('Codes starting from 500','QE33',0,1)

INSERT INTO tblQuestions
values('QE34','Name the location of compiled class files within a war file? Select the one correct answer.','2/5/2021','PRJ321',1)
INSERT INTO tblAnswers
values('/META-INF/classes','QE34',0,1)
INSERT INTO tblAnswers
values('/classes','QE34',0,1)
INSERT INTO tblAnswers
values('/WEB-INF/classes','QE34',1,1)
INSERT INTO tblAnswers
values('/root/classes','QE34',0,1)

INSERT INTO tblQuestions
values('QE35','What request header must be set for parameter data to be decoded from a form?','2/5/2021','PRJ321',1)
INSERT INTO tblAnswers
values('EncType: application /x-www-urlencoded','QE35',0,1)
INSERT INTO tblAnswers
values('Content-Type: application /x-www-form-urlencoded','QE35',1,1)
INSERT INTO tblAnswers
values('Content-Type: multipart /form-data','QE35',0,1)
INSERT INTO tblAnswers
values('Encoding-Type: multipart /form-data','QE35',0,1)

INSERT INTO tblQuestions
values('QE36','Which of the following methods can be used to add cookies to a servlet response?','2/5/2021','PRJ321',1)
INSERT INTO tblAnswers
values('HttpServletResponse.addCookie(Cookie cookie).','QE36',1,1)
INSERT INTO tblAnswers
values('ServletResponse.addCookie(Cookie cookie).','QE36',0,1)
INSERT INTO tblAnswers
values('HttpServletResponse.addCookie(String contents).','QE36',0,1)
INSERT INTO tblAnswers
values('ServletResponse.addCookie(String contents).','QE36',0,1)

INSERT INTO tblQuestions
values('QE37','Which of the following JSP variables are not available within a JSP expression.','2/5/2021','PRJ321',1)
INSERT INTO tblAnswers
values('out','QE37',0,1)
INSERT INTO tblAnswers
values('httpsession','QE37',1,1)
INSERT INTO tblAnswers
values('session','QE37',0,1)
INSERT INTO tblAnswers
values('response','QE37',0,1)

INSERT INTO tblQuestions
values('QE38','Identify statements that are always true about threads running through the service() method of a servlet with the following class declaration.','2/5/2021','PRJ321',1)
INSERT INTO tblAnswers
values('The destroy() method never cuts short threads running through the service() method.','QE38',0,1)
INSERT INTO tblAnswers
values('Threads running through the service() method must run one at a time.','QE38',0,1)
INSERT INTO tblAnswers
values('There could be anything from zero to many threads running through the service() method during the time the servlet is loaded.','QE38',1,1)
INSERT INTO tblAnswers
values('At least one thread will run through the service() method if init() has been executed.','QE38',0,1)

INSERT INTO tblQuestions
values('QE39','Name the default value of the scope atribute of <jsp:usebean>.','2/5/2021','PRJ321',1)
INSERT INTO tblAnswers
values('page','QE39',1,1)
INSERT INTO tblAnswers
values('application','QE39',0,1)
INSERT INTO tblAnswers
values('session','QE39',0,1)
INSERT INTO tblAnswers
values('request','QE39',0,1)

INSERT INTO tblQuestions
values('QE40','Which of these are legal attributes of page directive.','2/5/2021','PRJ321',1)
INSERT INTO tblAnswers
values('session','QE40',1,1)
INSERT INTO tblAnswers
values('include','QE40',0,1)
INSERT INTO tblAnswers
values('scope','QE40',0,1)
INSERT INTO tblAnswers
values('debug','QE40',0,1)

INSERT INTO tblQuestions
values('QE41','What keyword is used to prevent an object from being serialized?','2/5/2021','PRO123',1)
INSERT INTO tblAnswers
values('private','QE41',0,1)
INSERT INTO tblAnswers
values('volatile','QE41',0,1)
INSERT INTO tblAnswers
values('protected','QE41',0,1)
INSERT INTO tblAnswers
values('transient','QE41',1,1)

INSERT INTO tblQuestions
values('QE42','Select the order of access modifiers from least restrictive to most restrictive.','2/5/2021','PRO123',1)
INSERT INTO tblAnswers
values('public, private, protected, default','QE42',0,1)
INSERT INTO tblAnswers
values('default, protected, private, public','QE42',0,1)
INSERT INTO tblAnswers
values('public, protected, default, private','QE42',1,1)
INSERT INTO tblAnswers
values('default, public, protected, private','QE42',0,1)

INSERT INTO tblQuestions
values('QE43','Which access modifier allows you to access method calls in libraries not created in Java?','2/5/2021','PRO123',1)
INSERT INTO tblAnswers
values('public','QE43',0,1)
INSERT INTO tblAnswers
values('native','QE43',1,1)
INSERT INTO tblAnswers
values('transient','QE43',0,1)
INSERT INTO tblAnswers
values('volatile','QE43',0,1)

INSERT INTO tblQuestions
values('QE44','Which of the following keywords is used to invoke a method in the parent class?','2/5/2021','PRO123',1)
INSERT INTO tblAnswers
values('this','QE44',0,1)
INSERT INTO tblAnswers
values('super','QE44',1,1)
INSERT INTO tblAnswers
values('final','QE44',0,1)
INSERT INTO tblAnswers
values('static','QE44',0,1)

INSERT INTO tblQuestions
values('QE45','What is the value of x after the following operation is performed? x = 23 % 4;','2/5/2021','PRO123',1)
INSERT INTO tblAnswers
values('3','QE45',1,1)
INSERT INTO tblAnswers
values('4','QE45',0,1)
INSERT INTO tblAnswers
values('23','QE45',0,1)
INSERT INTO tblAnswers
values('5','QE45',0,1)

INSERT INTO tblQuestions
values('QE46','What method call is used to tell a thread that it has the opportunity to run?','2/5/2021','PRO123',1)
INSERT INTO tblAnswers
values('wait()','QE46',0,1)
INSERT INTO tblAnswers
values('notify()','QE46',1,1)
INSERT INTO tblAnswers
values('run()','QE46',0,1)
INSERT INTO tblAnswers
values('start()','QE46',0,1)

INSERT INTO tblQuestions
values('QE47','Assertions are used to enforce all but which of the following?','2/5/2021','PRO123',1)
INSERT INTO tblAnswers
values('Preconditions','QE47',0,1)
INSERT INTO tblAnswers
values('Postconditions','QE47',0,1)
INSERT INTO tblAnswers
values('Exceptions','QE47',0,1)
INSERT INTO tblAnswers
values('Class invariants','QE47',1,1)

INSERT INTO tblQuestions
values('QE48','How many bits does a float contain?','2/5/2021','PRO123',1)
INSERT INTO tblAnswers
values('1','QE48',0,1)
INSERT INTO tblAnswers
values('8','QE48',0,1)
INSERT INTO tblAnswers
values('32','QE48',1,1)
INSERT INTO tblAnswers
values('64','QE48',0,1)

INSERT INTO tblQuestions
values('QE49','Select the list of primitives ordered in smallest to largest bit size representation.','2/5/2021','PRO123',1)
INSERT INTO tblAnswers
values('boolean, char, byte, double','QE49',0,1)
INSERT INTO tblAnswers
values('byte, int, float, char','QE49',0,1)
INSERT INTO tblAnswers
values('char, short, long, float','QE49',0,1)
INSERT INTO tblAnswers
values('char, int, float, long','QE49',1,1)

INSERT INTO tblQuestions
values('QE50','Which class provides locale-sensitive text formatting for date and time information?','2/5/2021','PRO123',1)
INSERT INTO tblAnswers
values('java.text.DateFormat','QE50',1,1)
INSERT INTO tblAnswers
values('java.text.TimeFormat','QE50',0,1)
INSERT INTO tblAnswers
values('java.util.DateFormat','QE50',0,1)
INSERT INTO tblAnswers
values('java.util.TimeFormat','QE50',0,1)

INSERT INTO tblQuestions
values('QE51','Which of the following statements accurately describes how variables are passed to methods?','2/5/2021','PRO123',1)
INSERT INTO tblAnswers
values('Arguments are always passed by value.','QE51',0,1)
INSERT INTO tblAnswers
values('Arguments that are primitive type are passed by value.','QE51',1,1)
INSERT INTO tblAnswers
values('Arguments are always passed by reference.','QE51',0,1)
INSERT INTO tblAnswers
values('Arguments that are passed with the & operator are passed by reference.','QE51',0,1)

INSERT INTO tblQuestions
values('QE52','How do you change the value that is encapsulated by a wrapper class after you have instan- tiated it?','2/5/2021','PRO123',1)
INSERT INTO tblAnswers
values('Use the setXXX() method defined for the wrapper class.','QE52',0,1)
INSERT INTO tblAnswers
values('Use the parseXXX() method defined for the wrapper class.','QE52',0,1)
INSERT INTO tblAnswers
values('Use the equals() method defined for the wrapper class.','QE52',0,1)
INSERT INTO tblAnswers
values('None of the above.','QE52',1,1)

INSERT INTO tblQuestions
values('QE53','If all three top-level elements occur in a source file, they must appear in which order?','2/5/2021','PRO123',1)
INSERT INTO tblAnswers
values('Package declaration, imports, class/interface/enum definitions.','QE53',1,1)
INSERT INTO tblAnswers
values('Package declaration must come first; order for imports and class/interfaces/enum definitions is not significant','QE53',0,1)
INSERT INTO tblAnswers
values('Classes/interfaces/enums, imports, package declarations','QE53',0,1)
INSERT INTO tblAnswers
values('Imports, package declarations, classes/interfaces/enums','QE53',0,1)

INSERT INTO tblQuestions
values('QE54','Consider the following line of code: int[] x = new int[25];','2/5/2021','PRO123',1)
INSERT INTO tblAnswers
values('x[24] is 0','QE54',1,1)
INSERT INTO tblAnswers
values('x[24] is undefined','QE54',0,1)
INSERT INTO tblAnswers
values('x[25] is 0','QE54',0,1)
INSERT INTO tblAnswers
values('x[0] is null','QE54',0,1)

INSERT INTO tblQuestions
values('QE55','What is the range of values that can be assigned to a variable of type short?','2/5/2021','PRO123',1)
INSERT INTO tblAnswers
values('Depends on the underlying hardware','QE55',0,1)
INSERT INTO tblAnswers
values('0 through 216 − 1','QE55',0,1)
INSERT INTO tblAnswers
values('0 through 232 − 1','QE55',0,1)
INSERT INTO tblAnswers
values('−215 through 215 − 1','QE55',1,1)

INSERT INTO tblQuestions
values('QE56','Suppose a source file contains a large number of import statements. How do the imports affect the time required to compile the source file?','2/5/2021','PRO123',1)
INSERT INTO tblAnswers
values('Compilation takes no additional time.','QE56',0,1)
INSERT INTO tblAnswers
values('Compilation takes slightly more time.','QE56',1,1)
INSERT INTO tblAnswers
values('Compilation takes significantly more time.','QE56',0,1)
INSERT INTO tblAnswers
values('Compilation takes additional time.','QE56',0,1)

INSERT INTO tblQuestions
values('QE57','Suppose a source file contains a large number of import statements and one class definition.','2/5/2021','PRO123',1)
INSERT INTO tblAnswers
values('Class loading takes no additional time.','QE57',1,1)
INSERT INTO tblAnswers
values('Class loading takes slightly more time.','QE57',0,1)
INSERT INTO tblAnswers
values('Class loading takes significantly more time.','QE57',0,1)
INSERT INTO tblAnswers
values('Class loading takes no significantly more time.','QE57',0,1)

INSERT INTO tblQuestions
values('QE58','When a negative long is cast to a byte, what are the possible values of the result?','2/5/2021','PRO123',1)
INSERT INTO tblAnswers
values('Positive','QE58',0,1)
INSERT INTO tblAnswers
values('Zero','QE58',0,1)
INSERT INTO tblAnswers
values('Negative','QE58',0,1)
INSERT INTO tblAnswers
values('All of the above','QE58',1,1)

INSERT INTO tblQuestions
values('QE59','When is it appropriate to pass a cause to an exception constructor?','2/5/2021','PRO123',1)
INSERT INTO tblAnswers
values('Always','QE59',0,1)
INSERT INTO tblAnswers
values('When the exception is being thrown in response to catching of a different exception type','QE59',1,1)
INSERT INTO tblAnswers
values('When the exception is being thrown from a public method','QE59',0,1)
INSERT INTO tblAnswers
values('When the exception is being thrown from a private method','QE59',0,1)

INSERT INTO tblQuestions
values('QE60','Which of the following should always be caught?','2/5/2021','PRO123',1)
INSERT INTO tblAnswers
values('Runtime exceptions','QE60',0,1)
INSERT INTO tblAnswers
values('Checked exceptions','QE60',1,1)
INSERT INTO tblAnswers
values('Assertion errors','QE60',0,1)
INSERT INTO tblAnswers
values('Errors other than assertion errors','QE60',0,1)


                    























