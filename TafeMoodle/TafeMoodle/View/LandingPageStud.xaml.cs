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

namespace TafeMoodle.View
{
    /// <summary>
    /// Interaction logic for LandingPageStud.xaml
    /// </summary>
    public partial class LandingPageStud : Page
    {
        int activeStudID;
        public LandingPageStud(int studID)
        {
            InitializeComponent();
            App.MainPageStud = this;

            activeStudID = studID;
            activeScreenFrame.Content = new Dashboard(studID);
        }

        private void searchBtn_Click(object sender, RoutedEventArgs e)
        {
            activeScreenFrame.Content = new CourseSearchStud(activeStudID);
        }

        private void dashboardBtn_Click(object sender, RoutedEventArgs e)
        {
            activeScreenFrame.Content = new Dashboard(activeStudID);
        }

        private void signOutBtn_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new LoginPage());
        }
    }
}
