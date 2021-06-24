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
    /// Interaction logic for UnitAdd.xaml
    /// </summary>
    public partial class UnitAdd : Page
    {
        DataAccessLayer dataAccess = new DataAccessLayer();
        List<Assessment> assessments = new List<Assessment>();

        public UnitAdd()
        {
            InitializeComponent();

        }

        private List<Assessment> getLBItems(ListBox assLB)
        {
            List<Assessment> assignments = new List<Assessment>();
            foreach (var item in assLB.Items)
            {
                string phrase = (string)item;
                string[] assValues = phrase.Split('|');

                Assessment anAss = new Assessment()
                {
                    assessmentName = assValues[0],
                    dueDate = assValues[1],
                    assessmentType = assValues[2]
                };
                assignments.Add(anAss); 
            }

            return assignments;
        }

        private void addAssBtn_Click(object sender, RoutedEventArgs e)
        {

            if (dueDateDP.SelectedDate != null)
            {
                Assessment ass = new Assessment()
                {
                    assessmentName = assNameTB.Text,
                    dueDate = dueDateDP.Text,
                    assessmentType = typeCB.Text
                };

                assessmentLB.Items.Add(ass.assessmentName + "|" + ass.assessmentType + "|" + ass.dueDate);
            }

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
            string unitName = unitNameTxt.Text;
            string unitType = unitTypeCB.Text;

            if (string.IsNullOrEmpty(unitName) || string.IsNullOrWhiteSpace(unitName))
            {

                MessageBox.Show("Cannot save changes with empty fields");
            }
            else
            {
                if (MessageBox.Show("Once you save this record, it cannot be reverted", "Confirmation", MessageBoxButton.OKCancel) == MessageBoxResult.OK)
                {
                    //Get all Assignment LB objs 
                    List<Assessment> addedAss = getLBItems(assessmentLB);

                    Unit newUnit = new Unit()
                    {
                        unitName = unitName,
                        unitType = unitType,
                        assessmentList = addedAss
                    };

                    //save to db 
                    dataAccess.addUnit(newUnit);
                    App.MainPage.activeScreenFrame.Content = new UnitSearch();
                }
            }
        }
    }
}
