using System;
using System.Collections.Generic;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using TafeMoodle.Data_Access_Layer;
using TafeMoodle.Model;

namespace TafeMoodle.View
{
    /// <summary>
    /// Interaction logic for SubjectInfo.xaml
    /// </summary>
    /// 

    public partial class SubjectInfo : Page
    {

        DataAccessLayer dataAccess = new DataAccessLayer();

        int thisSubID;

        public SubjectInfo(int subID)
        {
            InitializeComponent();

            thisSubID = subID;

            //Populate this screen
            Subject aSubject = dataAccess.getSubInfoByID(thisSubID);

            this.DataContext = aSubject;

            //Populate unitsLB
            foreach (Unit unit in aSubject.unitList)
            {
                unitsLB.Items.Add(unit.unitID + ": " + unit.unitName + "[" + unit.unitType + "]");
            }
        }

        private void GoBackBtn_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.GoBack();
        }

        private void DeleteBtn_Click(object sender, RoutedEventArgs e)
        {
            if (MessageBox.Show("Once you delete this record, it cannot be recovered", "Confirmation", MessageBoxButton.OKCancel) == MessageBoxResult.OK)
            {
                dataAccess.deleteSubByID(thisSubID);

                App.MainPage.activeScreenFrame.Content = new StudentSearch();
            }
        }

        private void saveBtn_Click(object sender, RoutedEventArgs e)
        {

            //Validate whether fields are null, empty or whitespace 
            if (string.IsNullOrEmpty(subNameTxt.Text) || string.IsNullOrWhiteSpace(subNameTxt.Text))
            {
                MessageBox.Show("Cannot save changes with empty fields");
            }


            else if (MessageBox.Show("Once you save this record, it cannot be reverted", "Confirmation", MessageBoxButton.OKCancel) == MessageBoxResult.OK)
            {
                Subject subject = new Subject()
                {
                    subID = thisSubID,
                    subName = subNameTxt.Text
                };

                //save to db 
                dataAccess.updateSub(subject);
                App.MainPage.activeScreenFrame.Content = new SubjectSearch();
            }
        }
    }
}
