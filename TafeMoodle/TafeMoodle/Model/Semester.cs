using System;
using System.Collections.Generic;
using System.Text;

namespace TafeMoodle.Model
{
    class Semester
    {
        public int semID { get; set; }

        public string semName { get; set; }

        public DateTime semStartDate { get; set; }

        public DateTime semFinishDate { get; set; }


        //Construct
        //public Semester(string semName, DateTime semStartDate, DateTime semFinishDate)
        //{
        //    this.semName = semName;
        //    this.semStartDate = semStartDate;
        //    this.semFinishDate = semFinishDate;
        //}

        //TODO : Add CRUD methods 

    }
}
