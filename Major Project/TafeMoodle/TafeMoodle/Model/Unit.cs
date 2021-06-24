using System;
using System.Collections.Generic;
using System.Text;

namespace TafeMoodle.Model
{
    class Unit
    {
        public int unitID { get; set; } //Note: This should be assigned via the db 
        public string unitName { get; set; }

        public string unitType { get; set; }

        public List<Assessment> assessmentList { get; set; }


        //Construct         //Note - Either implement a method for assigning an assessment to the course later or make this part of the construct
        //public Unit(String unitName, string unitType)
        //{
        //    this.unitName = unitName;
        //    this.unitType = unitType;
        //}

        //TODO: Add CRUD methods 



    }
}
