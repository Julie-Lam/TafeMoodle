using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;

namespace TafeMoodle.Model
{
    class Student : IUser
    {
        public int userID { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
        public Address address { get; set; }
        public string mobNum { get; set; }
        public string sex { get; set; }
        public string emailUsername { get; set; }
        public string password { get; set; }

        public List<Course> enrolledCourseList;


        //Construct
        //public Student(string firstName, string lastName, int mobNum)
        //{
        //    this.firstName = firstName;
        //    this.lastName = lastName;
        //    this.mobNum = mobNum;
        //}


        //Methods
        //TODO: Implement these Student methods 

        public void enroll()
        {
            throw new NotImplementedException();
        }

        public void unenroll()
        {
            throw new NotImplementedException();
        }
    }

}
