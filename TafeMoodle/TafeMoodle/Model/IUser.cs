using System;
using System.Collections.Generic;
using System.Text;

namespace TafeMoodle.Model
{
    interface IUser
    {
        int userID { get; set; }
        string firstName { get; set; }
        string lastName { get; set; }
        string mobNum { get; set; }
        string sex { get; set; }
        string emailUsername { get; set; }
        string password { get; set; }

    }
}
