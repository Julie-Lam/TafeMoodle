using System;
using System.Collections.Generic;
using System.Text;

namespace TafeMoodle.Model
{
    class Teacher : IUser
    {
        //Properties 
        public int userID { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
        public Address address { get; set; }
        public string mobNum { get; set; }
        public string sex { get; set; }
        public string emailUsername { get; set; }
        public string password { get; set; }

        public List<Course> courseList;


        //Constructor
        //public Teacher(string username, string password)
        //{
        //    this.emailUsername = username;
        //    this.password = password;
        //}

        //Methods
        //TODO: Implement these Teacher methods
        public void AddUser()
        {

            throw new NotImplementedException();
        }

        public IUser ViewAllUsers()
        {
            throw new NotImplementedException();
        }

        public IUser UpdateUser()
        {
            throw new NotImplementedException();
        }

        public void DeleteUser()
        {
            throw new NotImplementedException();
        }

        public IUser SearchUser()
        {
            throw new NotImplementedException();
        }



    }
}
