   M S B A M L   `   `   `  ����E  ATafeMoodle, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null1clr-namespace:TafeMoodle.ViewTafeMoodle.View  5      &     TafeMoodle.View.CourseSearchStud   5      \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      /localclr-namespace:TafeMoodle.View     5        N� Title$  CourseSearchStud��5	      .��5      �  � ColumnDefinitions 5   
   �� 5      $��* �6   �� 5      $��* �6   �� 5      $��* �6    � RowDefinitions 5   
   �� 5      $��75 �6   �� 5      $	��100 �6   �� 5      $��* �6   �� 5      $	��100 �6   .+�5   
   �� $��3��6   $��4��5       J� Opacity$	 0.8Q�5      ��5      �� 5      .��5      �  � Color$ #7be9f6��6#    � Offset$	 0.0Q�63   � 5      $ #f083da��6#   $ 1Q�63   5      5!      � 5#   
   $��0��6   $��3��6   $��0��63   .+�5$      �� $��Courses��6   $��30(�5%      
�������$��Center=�5'      $��	0 10 0 10q�5(      5)      � 5*   
   $��0��6   $��3��6   $��1��63   .+�5+      �� $��	20 0 20 0q�6   
���p�.+�5-      ��  �� Orientation$ 
Horizontal=�6   $��	20 0 20 0q�66   $��Center=�5.      .+�5/      �� $	��200��6!   $��5 0 5 0q�6-   .+�51      �� $��Search Course: ��6    $��18(�6:   
�������52   5   �� 53      -   5         ��Name$ searchInput��53   "   54      �� 56      $	��200��6!   $��5 0 5 0q�6-   .+�57      �� $
��By: ��6    $��18(�6/   
�������58   5   �� 59      -   5         ��Name$ searchFilter��59   #   .@�5:      �� 	 �� 
IsSelected$
	 True��6+   .��6=   Course Name6J   �� 5;      .��6+   	Course ID66   5<      5?      5@      �� 5A      $��	0 20 0 20q�6   $ 
Horizontal=�60   $��Center=�5B      .+�5D      �� $��0 0 10 0q�6!   .+�5E      �� -   5        
 ��Name$
 viewAllCoursesBtn��5E   !   $��View All Courses��5F   !   5G   !   5H      �� 5I      .+�5J      �� -   5        $
 searchCourseBtn��5J   !   $��Search Courses��5K      5L      5M      5O      5Q      5R      � 5S   
   $��0��6   $��3��6   $��2��63   $��	20 0 20 0q�5T      .+�5U      &   System.Windows.Controls.DataGrid  -   5        $��
myDataGrid��5U      $��Stretch=�5V      $��Stretch=�5W         CanUserAddRows$ False��5X         SelectionMode$ Single=�5Y      5[      � 5]   
   $��0��6   $��3��6   $��3��63   $��	20 0 20 0q�5^      .+�5e      �� -   5        $
 
seeMoreBtn��5i      $��See More��5e      $��Center=�5f      $��Center=�5g      $��10q�5h      5j      5l      5m      5n      