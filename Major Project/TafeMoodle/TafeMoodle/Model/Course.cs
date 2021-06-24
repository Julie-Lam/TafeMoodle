using System;
using System.Collections.Generic;
using System.Text;

namespace TafeMoodle.Model
{
    class Course
    {
        public int courseID { get; set; }
        public string courseName { get; set; }
        public int durationWks { get; set; }
        public double fee { get; set; }
        public string studyMode { get; set; }
        public List<Semester> semesterList { get; set; }
        public List<Location> locationList { get; set; }
        public List<Subject> subjectList { get; set; }


        //public Course(int courseID, String courseName, int durationWks, double fee, string studyMode)
        //{
        //    this.courseID = courseID;
        //    this.courseName = courseName;
        //    this.durationWks = durationWks;
        //    this.fee = fee;
        //    this.studyMode = studyMode;
        //}

    }
}
