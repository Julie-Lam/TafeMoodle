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
using TafeMoodle.Model;
using TafeMoodle.Data_Access_Layer;

namespace TafeMoodle.View
{
    /// <summary>
    /// Interaction logic for SubjectAdd.xaml
    /// </summary>
    /// 

    public partial class SubjectAdd : Page
    {

        DataAccessLayer dataAccess = new DataAccessLayer();

        public SubjectAdd()
        {
            InitializeComponent();

            populateSubID(subIDTxt);

            populateUnitListUI(unitListStackPanel);

            populateTeachersUI(teachersStack);

        }

        public void populateUnitListUI(StackPanel unitListStackPanel)
        {

            //Grab from db all distinct units
            List<Unit> allAvailUnits = dataAccess.getAllUnits();

            foreach (var unit in allAvailUnits)
            {
                CheckBox cb = new CheckBox();
                cb.Content = unit.unitID + ": " + unit.unitName + "[" + unit.unitType + "]";
                unitListStackPanel.Children.Add(cb);
            }
        }

        public void populateTeachersUI(StackPanel teachersStack)
        {

            //Grab from db all distinct units
            List<Teacher> allAvailTeachers = dataAccess.getAllTeachers();

            foreach (var teacher in allAvailTeachers)
            {
                CheckBox cb = new CheckBox();
                cb.Content = teacher.userID + ": " + teacher.firstName + " " + teacher.lastName;
                teachersStack.Children.Add(cb);
            }

        }

        public void populateSubID(TextBox idTextBox)
        {
            int nextSubID = dataAccess.getLatestSubID();

            idTextBox.Text = nextSubID.ToString();
        }

        private bool isValidateCBField(StackPanel stackPanel)
        {
            bool CBSelected = false;

            foreach (CheckBox item in stackPanel.Children)
            {
                if (item.IsChecked == true)
                {
                    CBSelected = true;
                }
            }

            return CBSelected;
        }

        public List<int> getSelectedCBItemIDs(StackPanel stackPanel)
        {
            List<int> selectedItemIDs = new List<int>();

            foreach (CheckBox item in stackPanel.Children)
            {
                if (item.IsChecked == true)
                {
                    string[] selectedItem = item.Content.ToString().Split(':');

                    selectedItemIDs.Add(int.Parse(selectedItem[0]));
                }
            }

            return selectedItemIDs;
        }

        private void goBackBtn_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.GoBack();
        }

        private void CancelBtn_Click(object sender, RoutedEventArgs e)
        {
            if (MessageBox.Show("Any information you have added so far will not be saved", "Confirmation", MessageBoxButton.OKCancel) == MessageBoxResult.OK)
            {
                NavigationService.GoBack();
            }
        }

        private void saveBtn_Click(object sender, RoutedEventArgs e)
        {

            if (isValidateCBField(unitListStackPanel) && isValidateCBField(teachersStack))
            {
                //Get all checked CB IDs in stack 
                List<int> selUnitIDs = getSelectedCBItemIDs(unitListStackPanel);
                List<int> selTeacherIDs = getSelectedCBItemIDs(teachersStack);

                //Validate whether fields are null, empty or whitespace 
                if (string.IsNullOrEmpty(subNameTxt.Text) || string.IsNullOrWhiteSpace(subNameTxt.Text))
                {
                    MessageBox.Show("Cannot save changes with empty fields");
                }

                else if (MessageBox.Show("Once you save this record, it cannot be reverted", "Confirmation", MessageBoxButton.OKCancel) == MessageBoxResult.OK)
                {
                    Subject subject = new Subject()
                    {
                        subID = int.Parse(subIDTxt.Text),
                        subName = subNameTxt.Text,
                    };

                    //save to db 
                    dataAccess.addSubject(subject, selUnitIDs, selTeacherIDs);
                    App.MainPage.activeScreenFrame.Content = new SubjectSearch();
                }


            }
            else
            {
                MessageBox.Show("Please ensure at least one unit is selected");
            }

        }



    }
}
