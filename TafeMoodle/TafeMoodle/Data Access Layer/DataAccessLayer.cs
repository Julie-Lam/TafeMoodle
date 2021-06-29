using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Text;
using System.Windows;
using TafeMoodle.Model;

namespace TafeMoodle.Data_Access_Layer
{
    class DataAccessLayer
    {
        private SqlConnection connectToDB()
        {
            //Laptop 
            string connStr = "Data Source=DESKTOP-I9SH45G;Initial Catalog=TafeMoodle;Integrated Security=True;";

            //Comp
            //string connStr = "Data Source=localhost\\SQLEXPRESS;Initial Catalog=TafeMoodle;Integrated Security=True;";

            SqlConnection sqlConn = new SqlConnection(connStr);

            try
            {
                sqlConn.Open();
            }
            catch (Exception ex)
            {

                MessageBox.Show("Critical Error: " + ex.Message);
            }


            return sqlConn;
        }



        //======= COURSE ======== //

        public DataTable getAllCoursesDataTable()
        {
            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("Select * FROM Course", conn);

                //Create sqlDataAdapter 
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                //Create the course Data Table 
                DataTable courseDataTable = new DataTable("Course");

                //Utilises the sqlDataAdapter class to populates the course Data Table
                sqlDataAdapter.Fill(courseDataTable);

                return courseDataTable;
            }
        }


        public List<Course> getAllCoursesList()
        {
            List<Course> allCourses = new List<Course>();

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("Select * FROM Course", conn);

                try
                {
                    SqlDataReader reader = sqlCommand.ExecuteReader();

                    while (reader.Read())
                    {
                        Course course = new Course();
                        course.courseID = (int)reader[0];
                        course.courseName = (string)reader[1];
                        course.durationWks = (int)reader[2];
                        course.fee = (double)reader[3];
                        course.studyMode = (string)reader[4];

                        allCourses.Add(course);
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error Retrieving Courses From DB: " + ex.Message);
                }
            }

            return allCourses;
        }



        public bool isCourseExistByID(int courseID)
        {
            bool isExist = false;
            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM COURSE " +
                                                       "WHERE CourseID = " + courseID, conn);
                SqlDataReader reader = sqlCommand.ExecuteReader();

                try
                {
                    if (reader.Read())
                    {
                        isExist = true;
                    }
                }
                catch (Exception ex)
                {

                    MessageBox.Show("Error Checking Course Exists in DB: " + ex.Message);
                }

            }

            return isExist;
        }



        public Course getCourseInfoByID(int courseID)
        {
            Course course = new Course();
            course.locationList = new List<Location>();
            course.subjectList = new List<Subject>();

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM COURSE " +
                                                       "WHERE CourseID = " + courseID, conn);

                try
                {
                    SqlDataReader reader = sqlCommand.ExecuteReader();
                    while (reader.Read())
                    {
                        course.courseID = (int)reader[0];
                        course.courseName = (string)reader[1];
                        course.durationWks = (int)reader[2];
                        course.fee = (double)reader[3];
                        course.studyMode = (string)reader[4];
                    }
                    reader.Close();

                    //Getting semester
                    course.semesterList = new List<Semester>();
                    sqlCommand = new SqlCommand("EXECUTE sp_vw_courseSems_byCourseID @courseID = " + courseID, conn);

                    reader = sqlCommand.ExecuteReader();

                    while (reader.Read())
                    {
                        Semester sem = new Semester()
                        {
                            semName = (string)reader[1],
                            semStartDate = (DateTime)reader[3],
                            semFinishDate = (DateTime)reader[4]
                        };

                        course.semesterList.Add(sem);
                    }

                    reader.Close();

                    //Getting location list
                    sqlCommand = new SqlCommand("EXECUTE sp_getCourseLocations_ByCourseID @varCourseID = " + courseID, conn);

                    reader = sqlCommand.ExecuteReader();

                    while (reader.Read())
                    {
                        Location location = new Location()
                        {
                            locationID = (int)reader[1],
                            address = (string)reader[2]

                        };
                        course.locationList.Add(location);
                    }

                    //Getting Subject list
                    reader.Close();

                    course.subjectList = getSubjectListByCourseID(courseID, conn);
                }
                catch (Exception ex)
                {

                    MessageBox.Show("Error Retrieving Course Details By ID From DB: " + ex.Message);
                }

            }

            return course;
        }



        public DataTable getCourseByName(string courseNameSearch)
        {
            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * " +
                                                       "FROM Course " +
                                                       "WHERE courseName LIKE '" +
                                                        courseNameSearch + "%'", conn);

                //Create sqlDataAdapter 
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                //Create the course Data Table 
                DataTable courseDataTable = new DataTable("Course");

                try
                {
                    //Utilises the sqlDataAdapter class to populates the course Data Table
                    sqlDataAdapter.Fill(courseDataTable);
                }
                catch (Exception ex)
                {

                    MessageBox.Show("Error Retrieving Course Details By Course Name From DB: " + ex.Message);
                }


                return courseDataTable;
            }
        }


        public DataTable getCourseByID(int courseID)
        {

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * " +
                                                       "FROM Course " +
                                                       "WHERE courseID = '" +
                                                        courseID + "';", conn);

                //Create sqlDataAdapter 
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                //Create the course Data Table 
                DataTable courseDataTable = new DataTable("Course");

                try
                {
                    //Utilises the sqlDataAdapter class to populates the course Data Table
                    sqlDataAdapter.Fill(courseDataTable);
                }
                catch (Exception ex)
                {

                    MessageBox.Show("Error Retrieving Course Details By Course ID From DB: " + ex.Message);
                }

                return courseDataTable;
            }

        }




        public void addCourse(Course course, List<int> semIDs, List<int> addressIDs, List<int> subIDs)
        {
            using (SqlConnection conn = connectToDB())
            {

                try
                {
                    SqlCommand sqlCommand1 = new SqlCommand("EXECUTE sp_InsertCourse1 '" + course.courseName + "', " + course.durationWks + ", " + course.fee + ", " + "' " + course.studyMode + "' ", conn);
                    sqlCommand1.ExecuteNonQuery();

                    foreach (var semID in semIDs)
                    {
                        SqlCommand sqlCommand2 = new SqlCommand("EXECUTE sp_InsertCourse2 " + semID, conn);
                        sqlCommand2.ExecuteNonQuery();
                    }

                    foreach (var addressID in addressIDs)
                    {
                        SqlCommand sqlCommand3 = new SqlCommand("EXECUTE sp_InsertCourse3 " + addressID, conn);
                        sqlCommand3.ExecuteNonQuery();
                    }

                    foreach (var subID in subIDs)
                    {
                        SqlCommand sqlCommand4 = new SqlCommand("EXECUTE sp_InsertCourse4 " + subID, conn);
                        sqlCommand4.ExecuteNonQuery();
                    }
                }
                catch (Exception ex)
                {

                    MessageBox.Show("Error Adding A New Course To DB: " + ex.Message);
                }

            }

        }


        public int getLatestCourseID()
        {
            int nextCourseID = 0;

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM vw_nextCourseID", conn);

                try
                {
                    nextCourseID = (int)sqlCommand.ExecuteScalar();
                }
                catch (Exception ex)
                {

                    MessageBox.Show("Error Determining The Next CourseID Value: " + ex.Message);
                }

            }

            return nextCourseID;
        }



        public DataTable getAllEnrolledCoursesByStudIDDataTable(int studID)
        {
            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("Select * FROM vw_enrolledCourseList WHERE studFK = " + studID, conn);

                //Create sqlDataAdapter 
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                //Create the course Data Table 
                DataTable enrCourseDataTable = new DataTable("Course");

                //Utilises the sqlDataAdapter class to populates the course Data Table
                sqlDataAdapter.Fill(enrCourseDataTable);

                return enrCourseDataTable;
            }
        }


        public void payEnrolledCourse(double payment, int studID, int courseID)
        {

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("EXECUTE sp_payEnrolledCourse " + payment + ", " + studID + ", " + courseID, conn);


                try
                {
                    sqlCommand.ExecuteNonQuery();
                }
                catch (Exception ex)
                {

                    MessageBox.Show("Error Making Payment for Enrolled Course: " + ex.Message);
                }
            }
        }

        //======= TEACHER ======== //

        private List<Teacher> LoadAllTeacherLogins()
        {
            List<Teacher> allTeacherLogins = new List<Teacher>();

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("Select * FROM Teacher", conn);

                try
                {
                    SqlDataReader reader = sqlCommand.ExecuteReader();

                    while (reader.Read())
                    {
                        Teacher teacher = new Teacher();
                        teacher.userID = (int)reader[0];
                        teacher.emailUsername = (string)reader[6];
                        teacher.password = (string)reader[7];

                        allTeacherLogins.Add(teacher);
                    }
                }
                catch (Exception ex)
                {

                    MessageBox.Show("Error Loading Teacher Logins: " + ex.Message);
                }
            }

            return allTeacherLogins;
        }

        public List<Teacher> getAllTeachers()
        {
            List<Teacher> allTeachers = new List<Teacher>();

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM Teacher ", conn);

                SqlDataReader reader = sqlCommand.ExecuteReader();

                while (reader.Read())
                {
                    Teacher teacher = new Teacher();
                    teacher.userID = (int)reader[0];
                    teacher.firstName = (string)reader[1];
                    teacher.lastName = (string)reader[2];

                    allTeachers.Add(teacher);
                }
            }

            return allTeachers;
        }


        public DataTable getAllTeachersDT()
        {
            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM Teacher", conn);

                //Create sqlDataAdapter 
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                //Create the course Data Table 
                DataTable teachDataTable = new DataTable("Teacher");

                //Utilises the sqlDataAdapter class to populate the course Data Table
                sqlDataAdapter.Fill(teachDataTable);

                return teachDataTable;
            }
        }


        public DataTable getTeachByName(string teachNameSearch)
        {
            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * " +
                                                       "FROM Teacher " +
                                                       "WHERE CONCAT(firstName, ' ', lastName) LIKE '" +
                                                        teachNameSearch + "%'", conn);

                //Create sqlDataAdapter 
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                //Create the stud Data Table 
                DataTable teachDataTable = new DataTable("Teacher");

                try
                {
                    //Utilises the sqlDataAdapter class to populates the course Data Table
                    sqlDataAdapter.Fill(teachDataTable);
                }
                catch (Exception ex)
                {

                    MessageBox.Show("Error Retrieving Teacher Details By Student Name From DB: " + ex.Message);
                }


                return teachDataTable;
            }
        }

        public DataTable getTeachByID(int teachID)
        {

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * " +
                                                       "FROM Teacher " +
                                                       "WHERE teachID = '" +
                                                        teachID + "';", conn);

                //Create sqlDataAdapter 
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                //Create the course Data Table 
                DataTable teachDataTable = new DataTable("Teacher");

                try
                {
                    //Utilises the sqlDataAdapter class to populates the course Data Table
                    sqlDataAdapter.Fill(teachDataTable);
                }
                catch (Exception ex)
                {

                    MessageBox.Show("Error Retrieving Teacher Details By Teacher ID From DB: " + ex.Message);
                }

                return teachDataTable;
            }

        }

        public bool isTeachExistByID(int teachID)
        {
            bool isExist = false;
            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM Teacher " +
                                                       "WHERE teacherID = " + teachID, conn);
                try
                {
                    SqlDataReader reader = sqlCommand.ExecuteReader();
                    if (reader.Read())
                    {
                        isExist = true;
                    }
                }
                catch (Exception ex)
                {

                    MessageBox.Show("Error Checking Teacher Exists in DB: " + ex.Message);
                }

            }

            return isExist;
        }

        public Teacher getTeachInfoByID(int teachID)
        {
            Teacher teacher = new Teacher();
            teacher.courseList = new List<Course>();
            teacher.address = new Address();

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM Teacher " +
                                                       "WHERE teacherID = " + teachID, conn);

                try
                {
                    SqlDataReader reader = sqlCommand.ExecuteReader();
                    while (reader.Read())
                    {
                        teacher.userID = (int)reader[0];
                        teacher.firstName = (string)reader[1];
                        teacher.lastName = (string)reader[2];

                        teacher.mobNum = (string)reader[4];
                        teacher.sex = (string)reader[5];
                        teacher.emailUsername = (string)reader[6];
                    }
                    reader.Close();

                    //Getting teacher list
                    sqlCommand = new SqlCommand("SELECT * FROM vw_TeacherCourseList WHERE teacherID = " + teachID, conn);

                    reader = sqlCommand.ExecuteReader();

                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            Course course = new Course()
                            {
                                courseID = (int)reader[0],
                                courseName = (string)reader[1]
                            };

                            teacher.courseList.Add(course);
                        }
                    }

                    reader.Close();

                    //Getting address 
                    sqlCommand = new SqlCommand("SELECT * FROM vw_teachAddressFull WHERE teacherID = " + teachID, conn);

                    reader = sqlCommand.ExecuteReader();
                    while (reader.Read())
                    {
                        teacher.address.addressID = (int)reader[1];
                        teacher.address.houseNum = (int)reader[2];
                        teacher.address.streetName = (string)reader[3];
                        teacher.address.suburb = (string)reader[4];
                        teacher.address.state = (string)reader[5];
                        teacher.address.postcode = (int)reader[6];
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error Retrieving Teacher Details By ID From DB: " + ex.Message);
                }
            }

            return teacher;
        }


        public void deleteTeachByID(int teachID)
        {
            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("EXECUTE sp_DeleteTeacherByTeacherID " + teachID, conn);

                sqlCommand.ExecuteNonQuery();
            }
        }


        public void updateTeach(Address address, Teacher teacher)
        {
            using (SqlConnection conn = connectToDB())
            {
                //Updates address
                SqlCommand sqlCommand = new SqlCommand("EXECUTE sp_updateTeachByID_1 " + address.addressID + ", " + address.houseNum + ", '" + address.streetName + "', '" + address.suburb + "', '" + address.state + "', " + address.postcode, conn);

                sqlCommand.ExecuteNonQuery();

                //Updates Student
                SqlCommand secSqlCommand = new SqlCommand("EXECUTE sp_updateTeachByID_2 " + teacher.userID + ", '" + teacher.firstName + "', '" + teacher.lastName + "', " + teacher.mobNum + ", '" + teacher.sex + "'", conn);

                secSqlCommand.ExecuteNonQuery();
            }

        }



        //======= LOGIN ======== //

        public Boolean isCorrectLogin(string emailUsername, string password, out int userID, out string userType)
        {
            Boolean isCorrectLogin = false;

            userID = -1;
            userType = "Unknown";

            List<IUser> users = new List<IUser>();

            foreach (Teacher aTeacher in LoadAllTeacherLogins())
            {
                users.Add(aTeacher);
            }

            foreach (Student aStudent in LoadAllStudentLogins())
            {
                users.Add(aStudent);
            }

            foreach (IUser aUser in users)
            {
                if (aUser.emailUsername == emailUsername && aUser.password == password)
                {
                    isCorrectLogin = true;

                    userID = aUser.userID;

                    userType = aUser.GetType().Name;
                }
            }

            return isCorrectLogin;
        }

        public Boolean isExistingUsername(string emailUsername)
        {
            Boolean isExistingUsername = false;

            List<IUser> users = new List<IUser>();

            foreach (Teacher aTeacher in LoadAllTeacherLogins())
            {
                users.Add(aTeacher);
            }

            foreach (Student aStudent in LoadAllStudentLogins())
            {
                users.Add(aStudent);
            }

            foreach (IUser aUser in users)
            {
                if (aUser.emailUsername == emailUsername)
                {
                    isExistingUsername = true;
                }
            }

            return isExistingUsername;
        }



        public string addTeacherToDB(string firstName, string lastName, string mobNum, string sex, string password, int houseNum, string streetName, string suburb, string state, int postcode)
        {
            int teachID = 0;
            string uniqueUsername;

            using (SqlConnection conn = connectToDB())
            {
                //Insert into Teacher Table and Address
                string sqlStrCommand = "EXEC sp_InsertATeacher @firstName = '" + firstName + "' , " +
                                                                 "@lastName = '" + lastName + "' , " +
                                                                 "@mobNum = " + mobNum + " , " +
                                                                 "@sex = '" + sex + "' , " +
                                                                 "@password = '" + password + "' , " +
                                                                 "@houseNum = " + houseNum + " , " +
                                                                 "@streetName = '" + streetName + "' , " +
                                                                 "@suburb = '" + suburb + "' , " +
                                                                 "@state = '" + state + "' , " +
                                                                 "@postcode = " + postcode;

                SqlCommand sqlCommand = new SqlCommand(sqlStrCommand, conn);

                sqlCommand.ExecuteNonQuery();

                //Update Teacher Table with AddressFK 
                SqlCommand secSqlCommand = new SqlCommand("EXEC sp_UpdateTeacherAfterSP", conn);

                secSqlCommand.ExecuteNonQuery();

                //Get TeacherID of recently added teacher
                SqlCommand thirdSqlCommand = new SqlCommand("EXEC sp_getRecentTeacherID", conn);
                teachID = (int)thirdSqlCommand.ExecuteScalar();

                uniqueUsername = firstName + "." + lastName + teachID + "@tafe.com";

                //Update Teacher Table with emailUsername
                string fourthCommand = "EXEC sp_UpdateTeacherEmailAfterSP @emailUsername = '" + uniqueUsername + "', " +
                                                                         "@teacherID =" + teachID;
                SqlCommand fourthSqlCommand = new SqlCommand(fourthCommand, conn);
                fourthSqlCommand.ExecuteNonQuery();
            }

            return uniqueUsername;
        }



        public void updateCourseNameDurFee(int courseID, string courseName, int duration, double fee)
        {
            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("EXECUTE sp_updateCourseByID" + " " + courseID + ", '" + courseName + "', " + duration + ", " + fee, conn);

                sqlCommand.ExecuteNonQuery();
            }

        }

        public void deleteCourseByID(int courseID)
        {
            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("EXECUTE sp_DeleteCourseByCourseID " + courseID, conn);

                sqlCommand.ExecuteNonQuery();
            }
        }




        //======= STUDENT ======== //

        public DataTable getAllStudentsDT()
        {
            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM vw_studAddress", conn);

                //Create sqlDataAdapter 
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                //Create the course Data Table 
                DataTable studDataTable = new DataTable("Student");

                //Utilises the sqlDataAdapter class to populate the course Data Table
                sqlDataAdapter.Fill(studDataTable);

                return studDataTable;
            }
        }

        public DataTable getStudByName(string studNameSearch)
        {
            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * " +
                                                       "FROM Student " +
                                                       "WHERE CONCAT(firstName, ' ', lastName) LIKE '" +
                                                        studNameSearch + "%'", conn);

                //Create sqlDataAdapter 
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                //Create the stud Data Table 
                DataTable studDataTable = new DataTable("Stud");

                try
                {
                    //Utilises the sqlDataAdapter class to populates the course Data Table
                    sqlDataAdapter.Fill(studDataTable);
                }
                catch (Exception ex)
                {

                    MessageBox.Show("Error Retrieving Student Details By Student Name From DB: " + ex.Message);
                }


                return studDataTable;
            }
        }

        public DataTable getStudByID(int studID)
        {

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * " +
                                                       "FROM Student " +
                                                       "WHERE studID = '" +
                                                        studID + "';", conn);

                //Create sqlDataAdapter 
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                //Create the course Data Table 
                DataTable studDataTable = new DataTable("Student");

                try
                {
                    //Utilises the sqlDataAdapter class to populates the course Data Table
                    sqlDataAdapter.Fill(studDataTable);
                }
                catch (Exception ex)
                {

                    MessageBox.Show("Error Retrieving Student Details By Student ID From DB: " + ex.Message);
                }

                return studDataTable;
            }

        }

        public Student getStudInfoByID(int studID)
        {
            Student student = new Student();
            student.enrolledCourseList = new List<Course>();
            student.address = new Address();

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM vw_studAddress " +
                                                       "WHERE studID = " + studID, conn);

                try
                {
                    SqlDataReader reader = sqlCommand.ExecuteReader();
                    while (reader.Read())
                    {
                        student.userID = (int)reader[0];
                        student.firstName = (string)reader[1];
                        student.lastName = (string)reader[2];

                        student.mobNum = (string)reader[4];
                        student.sex = (string)reader[5];
                        student.emailUsername = (string)reader[6];
                    }
                    reader.Close();

                    //Getting enrolled courses
                    sqlCommand = new SqlCommand("SELECT * FROM vw_EnrolledStudents WHERE studID = " + studID, conn);

                    reader = sqlCommand.ExecuteReader();

                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            Course course = new Course()
                            {
                                courseID = (int)reader[0],
                                courseName = (string)reader[1]
                            };

                            student.enrolledCourseList.Add(course);
                        }
                    }

                    reader.Close();

                    //Getting address 
                    sqlCommand = new SqlCommand("SELECT * FROM vw_studAddressFull WHERE studID = " + studID, conn);

                    reader = sqlCommand.ExecuteReader();
                    while (reader.Read())
                    {
                        student.address.addressID = (int)reader[1];
                        student.address.houseNum = (int)reader[2];
                        student.address.streetName = (string)reader[3];
                        student.address.suburb = (string)reader[4];
                        student.address.state = (string)reader[5];
                        student.address.postcode = (int)reader[6];
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error Retrieving Student Details By ID From DB: " + ex.Message);
                }

            }

            return student;
        }
        public List<Student> getEnrolledStudsByCourseID(int courseID)
        {

            List<Student> enrolledStudents = new List<Student>();

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("EXEC sp_EnrolledStudentsByCourseID @courseID = " + courseID, conn);

                SqlDataReader reader = sqlCommand.ExecuteReader();

                while (reader.Read())
                {
                    Student course = new Student();
                    course.userID = (int)reader[2];
                    course.firstName = (string)reader[3];
                    course.lastName = (string)reader[4];

                    enrolledStudents.Add(course);
                }
            }

            return enrolledStudents;
        }

        private List<Student> LoadAllStudentLogins()
        {
            List<Student> allStudentLogins = new List<Student>();

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("Select * FROM Student", conn);

                SqlDataReader reader = sqlCommand.ExecuteReader();

                while (reader.Read())
                {
                    Student student = new Student();
                    student.userID = (int)reader[0];
                    student.emailUsername = (string)reader[6];
                    student.password = (string)reader[7];

                    allStudentLogins.Add(student);
                }
            }

            return allStudentLogins;
        }

        public string addStudentToDB(string firstName, string lastName, string mobNum, string sex, string password, int houseNum, string streetName, string suburb, string state, int postcode)
        {
            int studID = 0;

            string uniqueUsername;

            using (SqlConnection conn = connectToDB())
            {
                //Insert into Student Table and Address
                string sqlStrCommand = "EXEC sp_InsertAStudent @firstName = '" + firstName + "' , " +
                                                              "@lastName = '" + lastName + "' , " +
                                                              "@mobNum = " + mobNum + " , " +
                                                              "@sex = '" + sex + "' , " +
                                                              "@password = '" + password + "' , " +
                                                              "@houseNum = " + houseNum + " , " +
                                                              "@streetName = '" + streetName + "' , " +
                                                              "@suburb = '" + suburb + "' , " +
                                                              "@state = '" + state + "' , " +
                                                              "@postcode = " + postcode;

                SqlCommand sqlCommand = new SqlCommand(sqlStrCommand, conn);

                sqlCommand.ExecuteNonQuery();

                //Update Student Table with AddressFK 
                SqlCommand secSqlCommand = new SqlCommand("EXEC sp_UpdateStudentAfterSP", conn);

                secSqlCommand.ExecuteNonQuery();

                //Get StudentID of recently added student 
                SqlCommand thirdSqlCommand = new SqlCommand("EXEC sp_getRecentStudID", conn);
                studID = (int)thirdSqlCommand.ExecuteScalar();

                uniqueUsername = firstName + "." + lastName + studID + "@tafe.com";

                //Update Student Table with emailUsername
                string fourthCommand = "EXEC sp_UpdateStudentEmailAfterSP @emailUsername = '" + uniqueUsername + "', " +
                                                                     "@studID =" + studID;
                SqlCommand fourthSqlCommand = new SqlCommand(fourthCommand, conn);
                fourthSqlCommand.ExecuteNonQuery();
            }

            return uniqueUsername;

        }

        public void updateStud(Address address, Student student)
        {
            using (SqlConnection conn = connectToDB())
            {
                //Updates address
                SqlCommand sqlCommand = new SqlCommand("EXECUTE sp_updateStudByID_1 " + address.addressID + ", " + address.houseNum + ", '" + address.streetName + "', '" + address.suburb + "', '" + address.state + "', " + address.postcode, conn);

                sqlCommand.ExecuteNonQuery();

                //Updates Student
                SqlCommand secSqlCommand = new SqlCommand("EXECUTE sp_updateStudByID_2 " + student.userID + ", '" + student.firstName + "', '" + student.lastName + "', " + student.mobNum + ", '" + student.sex + "'", conn);

                secSqlCommand.ExecuteNonQuery();
            }

        }

        public void deleteStudByID(int studID)
        {
            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("EXECUTE sp_DeleteStudByStudID " + studID, conn);

                sqlCommand.ExecuteNonQuery();
            }
        }

        public bool isStudExistByID(int studID)
        {
            bool isExist = false;
            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM Student " +
                                                       "WHERE studID = " + studID, conn);
                SqlDataReader reader = sqlCommand.ExecuteReader();

                try
                {
                    if (reader.Read())
                    {
                        isExist = true;
                    }
                }
                catch (Exception ex)
                {

                    MessageBox.Show("Error Checking Student Exists in DB: " + ex.Message);
                }

            }

            return isExist;
        }

        public int getLatestStudID()
        {
            int nextStudID;

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM vw_nextStudID", conn);

                nextStudID = (int)sqlCommand.ExecuteScalar();
            }

            return nextStudID;
        }


        public bool enrollStud(int courseID, int studID)
        {

            bool canEnroll = true;
            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("EXECUTE sp_enrollStud " + courseID + ", " + studID, conn);

                try
                {
                    sqlCommand.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {

                    MessageBox.Show("Error enrolling Student: " + ex.Message);
                    canEnroll = false;
                }
            }

            return canEnroll;
        }

        public void unEnrollStud(int courseID, int studID)
        {

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("EXECUTE sp_unenroll " + courseID + ", " + studID, conn);

                try
                {
                    sqlCommand.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {

                    MessageBox.Show("Error Un-Enrolling Student: " + ex.Message);
                }
            }

        }




        //======= SUBJECT ======== //

        public DataTable getAllSubjectsDT()
        {
            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM subject", conn);

                //Create sqlDataAdapter 
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                //Create the subject Data Table 
                DataTable subDataTable = new DataTable("Subject");

                //Utilises the sqlDataAdapter class to populate the course Data Table
                sqlDataAdapter.Fill(subDataTable);

                return subDataTable;
            }
        }

        public List<Subject> getAllSubs()
        {
            List<Subject> allAvailSubs = new List<Subject>();

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM Subject", conn);

                SqlDataReader reader = sqlCommand.ExecuteReader();

                while (reader.Read())
                {
                    Subject sub = new Subject();
                    sub.subID = (int)reader[0];
                    sub.subName = (string)reader[1];


                    allAvailSubs.Add(sub);
                }
            }

            return allAvailSubs;
        }


        private List<Subject> getSubjectListByCourseID(int courseID, SqlConnection conn)
        {
            List<Subject> subjectList = new List<Subject>();
            SqlCommand sqlCommand = new SqlCommand("EXECUTE sp_getCourseSubjects @varCourseID = " + courseID, conn);
            SqlDataReader reader = sqlCommand.ExecuteReader();

            while (reader.Read())
            {

                Subject subject = new Subject()
                {
                    subName = (string)reader[1]
                };

                subjectList.Add(subject);
            }

            return subjectList;
        }


        public DataTable getSubByName(string subNameSearch)
        {
            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * " +
                                                       "FROM Subject " +
                                                       "WHERE subName LIKE '" +
                                                        subNameSearch + "%'", conn);

                //Create sqlDataAdapter 
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                //Create the sub Data Table 
                DataTable subDataTable = new DataTable("Sub");

                try
                {
                    //Utilises the sqlDataAdapter class to populates the course Data Table
                    sqlDataAdapter.Fill(subDataTable);
                }
                catch (Exception ex)
                {

                    MessageBox.Show("Error Retrieving Subject Details By Subject Name From DB: " + ex.Message);
                }


                return subDataTable;
            }
        }

        public DataTable getSubByID(int subID)
        {

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * " +
                                                       "FROM Subject " +
                                                       "WHERE subID = '" +
                                                        subID + "';", conn);

                //Create sqlDataAdapter 
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                //Create the course Data Table 
                DataTable subDataTable = new DataTable("Subject");

                try
                {
                    //Utilises the sqlDataAdapter class to populates the course Data Table
                    sqlDataAdapter.Fill(subDataTable);
                }
                catch (Exception ex)
                {

                    MessageBox.Show("Error Retrieving Subject Details By Subject ID From DB: " + ex.Message);
                }

                return subDataTable;
            }

        }

        public bool isSubjectExistByID(int subID)
        {
            bool isExist = false;
            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM Subject " +
                                                       "WHERE subID = " + subID, conn);
                SqlDataReader reader = sqlCommand.ExecuteReader();

                try
                {
                    if (reader.Read())
                    {
                        isExist = true;
                    }
                }
                catch (Exception ex)
                {

                    MessageBox.Show("Error Checking Subject Exists in DB: " + ex.Message);
                }

            }

            return isExist;
        }


        public Subject getSubInfoByID(int subID)
        {
            Subject subject = new Subject();
            subject.unitList = new List<Unit>();

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM Subject " +
                                                       "WHERE subID = " + subID, conn);

                try
                {
                    SqlDataReader reader = sqlCommand.ExecuteReader();
                    while (reader.Read())
                    {
                        subject.subID = (int)reader[0];
                        subject.subName = (string)reader[1];
                    }

                    reader.Close();

                    //Getting unitList
                    sqlCommand = new SqlCommand("SELECT * FROM vw_subUnits WHERE subID = " + subID, conn);

                    reader = sqlCommand.ExecuteReader();

                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            Unit unit = new Unit()
                            {
                                unitID = (int)reader[2],
                                unitName = (string)reader[3],
                                unitType = (string)reader[4]
                            };

                            subject.unitList.Add(unit);
                        }
                    }

                    reader.Close();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error Retrieving Subject Details By ID From DB: " + ex.Message);
                }
            }

            return subject;
        }


        public void deleteSubByID(int subID)
        {
            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("EXECUTE sp_DeleteSubBySubID " + subID, conn);

                sqlCommand.ExecuteNonQuery();
            }
        }

        public void updateSub(Subject subject)
        {
            using (SqlConnection conn = connectToDB())
            {
                //Updates Subject
                SqlCommand sqlCommand = new SqlCommand("EXECUTE sp_updateSubByID " + subject.subID + ", '" + subject.subName + "'", conn);

                sqlCommand.ExecuteNonQuery();
            }

        }

        public int getLatestSubID()
        {
            int nextSubID = 0;

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM vw_nextSubID", conn);

                try
                {
                    nextSubID = (int)sqlCommand.ExecuteScalar();
                }
                catch (Exception ex)
                {

                    MessageBox.Show("Error Determining The Next SubID Value: " + ex.Message);
                }

            }

            return nextSubID;
        }



        public void addSubject(Subject subject, List<int> unitIDs, List<int> teacherIDs)
        {
            using (SqlConnection conn = connectToDB())
            {
                try
                {
                    SqlCommand sqlCommand1 = new SqlCommand("EXECUTE sp_InsertSubject1 '" + subject.subName + "'", conn);
                    sqlCommand1.ExecuteNonQuery();

                    foreach (var unitID in unitIDs)
                    {
                        SqlCommand sqlCommand2 = new SqlCommand("EXECUTE sp_InsertSubject2 " + unitID, conn);
                        sqlCommand2.ExecuteNonQuery();
                    }

                    foreach (var teacherID in teacherIDs)
                    {
                        SqlCommand sqlCommand3 = new SqlCommand("EXECUTE sp_InsertSubject3 " + teacherID, conn);
                        sqlCommand3.ExecuteNonQuery();
                    }

                }
                catch (Exception ex)
                {

                    MessageBox.Show("Error Adding A New Subject To DB: " + ex.Message);
                }

            }
        }


        //======= UNIT ======== //


        public List<Unit> getAllUnits()
        {
            List<Unit> allUnits = new List<Unit>();

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM Unit ", conn);

                SqlDataReader reader = sqlCommand.ExecuteReader();

                while (reader.Read())
                {
                    Unit unit = new Unit();
                    unit.unitID = (int)reader[0];
                    unit.unitName = (string)reader[1];
                    unit.unitType = (string)reader[2];

                    allUnits.Add(unit);
                }
            }

            return allUnits;
        }
        public DataTable getAllUnitsDT()
        {
            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM Unit", conn);

                //Create sqlDataAdapter 
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                //Create the course Data Table 
                DataTable unitDataTable = new DataTable("Unit");

                //Utilises the sqlDataAdapter class to populate the course Data Table
                sqlDataAdapter.Fill(unitDataTable);

                return unitDataTable;
            }
        }

        public bool isUnitExistByID(int unitID)
        {
            bool isExist = false;
            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM Unit " +
                                                       "WHERE unitID = " + unitID, conn);
                SqlDataReader reader = sqlCommand.ExecuteReader();

                try
                {
                    if (reader.Read())
                    {
                        isExist = true;
                    }
                }
                catch (Exception ex)
                {

                    MessageBox.Show("Error Checking Unit Exists in DB: " + ex.Message);
                }

            }

            return isExist;
        }

        public DataTable getUnitByName(string unitNameSearch)
        {
            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * " +
                                                       "FROM Unit " +
                                                       "WHERE unitName LIKE '" +
                                                        unitNameSearch + "%'", conn);

                //Create sqlDataAdapter 
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                //Create the sub Data Table 
                DataTable unitDataTable = new DataTable("Unit");

                try
                {
                    //Utilises the sqlDataAdapter class to populates the course Data Table
                    sqlDataAdapter.Fill(unitDataTable);
                }
                catch (Exception ex)
                {

                    MessageBox.Show("Error Retrieving Unit Details By Unit Name From DB: " + ex.Message);
                }

                return unitDataTable;
            }
        }

        public DataTable getUnitByID(int unitID)
        {

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * " +
                                                       "FROM Unit " +
                                                       "WHERE unitID = '" +
                                                        unitID + "';", conn);

                //Create sqlDataAdapter 
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                //Create the course Data Table 
                DataTable unitDataTable = new DataTable("Unit");

                try
                {
                    //Utilises the sqlDataAdapter class to populates the course Data Table
                    sqlDataAdapter.Fill(unitDataTable);
                }
                catch (Exception ex)
                {

                    MessageBox.Show("Error Retrieving Unit Details By Unit ID From DB: " + ex.Message);
                }

                return unitDataTable;
            }
        }


        public Unit getUnitInfoByID(int unitID)
        {
            Unit unit = new Unit();
            unit.assessmentList = new List<Assessment>();

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM Unit " +
                                                       "WHERE unitID = " + unitID, conn);

                try
                {
                    SqlDataReader reader = sqlCommand.ExecuteReader();
                    while (reader.Read())
                    {
                        unit.unitID = (int)reader[0];
                        unit.unitName = (string)reader[1];
                        unit.unitType = (string)reader[2];
                    }

                    reader.Close();

                    //Getting assessmentList
                    sqlCommand = new SqlCommand("SELECT * FROM vw_unitAssessments WHERE unitID = " + unitID, conn);

                    reader = sqlCommand.ExecuteReader();

                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            Assessment assessment = new Assessment()
                            {
                                assessmentID = (int)reader[2],
                                assessmentName = (string)reader[3],
                                dueDate = (string)reader[4],
                                assessmentType = (string)reader[5]
                            };

                            unit.assessmentList.Add(assessment);
                        }
                    }

                    reader.Close();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error Retrieving Unit Details By ID From DB: " + ex.Message);
                }
            }

            return unit;
        }


        public void addUnit(Unit unit)
        {
            using (SqlConnection conn = connectToDB())
            {
                try
                {
                    SqlCommand sqlCommand1 = new SqlCommand("EXECUTE sp_InsertUnit1 '" + unit.unitName + "', '" + unit.unitType + "'", conn);
                    sqlCommand1.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error Adding A New Unit To DB: " + ex.Message);
                }
            }


            foreach (var ass in unit.assessmentList)
            {
                using (SqlConnection conn = connectToDB())
                {
                    SqlCommand sqlCommand2 = new SqlCommand("EXECUTE sp_InsertUnit2 '" + ass.assessmentName + "', '" + ass.dueDate + "', '" + ass.assessmentType + "' ", conn);
                    sqlCommand2.ExecuteNonQuery();
                }
                using (SqlConnection conn = connectToDB())
                {
                    SqlCommand sqlCommand3 = new SqlCommand("EXECUTE sp_InsertUnit3", conn);
                    sqlCommand3.ExecuteNonQuery();
                }
            }
        }

        public void deleteUnitByID(int unitID)
        {
            try
            {
                using (SqlConnection conn = connectToDB())
                {
                    SqlCommand sqlCommand = new SqlCommand("EXECUTE sp_DeleteUnitByUnitID " + unitID, conn);

                    sqlCommand.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error deleting Unit by Unit ID: " + ex.Message);
            }

        }


        //======= LOCATION ======== //
        public List<Location> getAllCourseLocations()
        {
            List<Location> allLocations = new List<Location>();

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM vw_allCourseLocs ", conn);

                SqlDataReader reader = sqlCommand.ExecuteReader();

                while (reader.Read())
                {
                    Location loc = new Location();
                    loc.locationID = (int)reader[0];
                    loc.address = (string)reader[1];

                    allLocations.Add(loc);
                }
            }

            return allLocations;
        }




        //======= SEMESTER ======= //

        public List<Semester> getAllSemesters()
        {
            List<Semester> allAvailSems = new List<Semester>();

            using (SqlConnection conn = connectToDB())
            {
                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM vw_allSemesters ", conn);

                SqlDataReader reader = sqlCommand.ExecuteReader();

                while (reader.Read())
                {
                    Semester sem = new Semester();
                    sem.semID = (int)reader[0];
                    sem.semStartDate = (DateTime)reader[1];
                    sem.semFinishDate = (DateTime)reader[2];

                    allAvailSems.Add(sem);
                }
            }

            return allAvailSems;

        }



    }
}
