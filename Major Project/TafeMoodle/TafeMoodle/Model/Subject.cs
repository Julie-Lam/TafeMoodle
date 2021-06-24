using System;
using System.Collections.Generic;
using System.Text;

namespace TafeMoodle.Model
{
    class Subject
    {
        //Props
        public int subID { get; set; }

        public string subName { get; set; }

        public List<Unit> unitList { get; set; }


        //Construct
        //public Subject(List<Unit> units)
        //{
        //    this.unitList = units;
        //}

        //TODO - Add CRUD methods 
    }
}
