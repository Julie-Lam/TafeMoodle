   M S B A M L   `   `   `  ����E  ATafeMoodle, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null1clr-namespace:TafeMoodle.ViewTafeMoodle.View  5      $    TafeMoodle.View.CourseInfoStud   5      \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      /localclr-namespace:TafeMoodle.View     5        N� Title$  CourseInfoStud��5	      .��5      � -   5         �Name$ courseInfoGrid��5       � ColumnDefinitions 5   
   �� 5      $��* �6   �� 5      $��* �6    � RowDefinitions 5   
   �� 5      $��75 �6   �� 5      $��* �6   �� 5      $	��100 �6   .+�5   
   �� $��4��6   $��10��5       J� Opacity$	 0.8Q�5      ��5      �� 5      .��5      �  � Color$ #7be9f6��6#    � Offset$	 0.0Q�63   � 5      $ #f083da��6#   $ 1Q�63   5      5      �� 5"   
   $��0��6   $��2��6$   $��0��68   $��Course Information��5#      $��30(�5$      
�������$��Center=�5&      $��	0 10 0 10q�5'      �� 5)   
   $��1��6   $��2��6#   .+�5*      ��  �� Orientation$ 
Horizontal=�6   $��0, 0, 0, 15q�62   .+�5+      �� 
�������$	 0.5Q�5,      $��2q�5-       �� CornerRadius$ 5��5.      $��10, 0, 10, 0q�5/      ._�50      �� .+�51      �� $
��ID: ��6"   $��20(�52   "   	 �� 
IsReadOnly$
	 True��53   "   �� 54      $��20(�55   "   $	��Top=�56   "   $��Center=�57   "   
������ $
��Left=�59   "   $	 0.5Q�5:   "   $��25��5;   "   $
	 True��5<   "   ��54   "   �� 
 �� Path$
 courseID�5<   "   5=      5>      �� 5@      
�������$	 0.5Q�5A      $��2q�5B      $ 5��5C      $��10, 0, 10, 0q�5D      ._�5E      �� .+�5F      �� $��Course: ��6"   $��20(�5G   "   $
	 True��5H   "   �� 5I      -   5         ��Name$ courseNameTxt��5Q   "   $��20(�5J   "   $	��Top=�5K   "   $��Center=�5L   "   
������ $
��Left=�5N   "   $	 0.5Q�5O   "   $��25��5P   "   $
	 True��5R   "   ��5I   "   �� $
 
courseName�5R   "   5S      5T      �� 5V      
�������$	 0.5Q�5W      $��2q�5X      $ 5��5Y      $��10, 0, 10, 0q�5Z      ._�5[      �� .+�5\      �� $��Weeks): ��6"   $��20(�5]   "   $
	 True��5^   "   �� 5_      -   5        $ durationTxt��5g   "   $��20(�5`   "   $	��Top=�5a   "   $��Center=�5b   "   
������ $
��Left=�5d   "   $	 0.5Q�5e   "   $��25��5f   "   $
	 True��5h   "   ��5_   "   �� $
 durationWks�5h   "   5i      5j      �� 5l      
�������$	 0.5Q�5m      $��2q�5n      $ 5��5o      $��10, 0, 10, 0q�5p      ._�5q      �� .+�5r      �� $��Fee: ��6"   $��20(�5s   "   $
	 True��5t   "   �� 5u      -   5        $ feeTxt��5}   "   $��20(�5v   "   $	��Top=�5w   "   $��Center=�5x   "   
������ $
��Left=�5z   "   $	 0.5Q�5{   "   $��25��5|   "   $
	 True��5~   "   ��5u   "   �� $	
 fee�5~   "   5      5�      5�      �� 5�      $ 
Horizontal=�6   $��0, 0, 0, 15q�62   .+�5�      �� 
�������$	 0.5Q�5�      $��2q�5�      $ 5��5�      $��10, 0, 10, 0q�5�      ._�5�      �� .+�5�      �� $��Study Mode: ��6"   $��20(�5�   "   $
	 True��5�   "   �� 5�      $��20(�5�   "   $	��Top=�5�   "   $��Center=�5�   "   
������ $
��Left=�5�   "   $	 0.5Q�5�   "   $��25��5�   "   $
	 True��5�   "   ��5�   "   �� $
 	studyMode�5�   "   5�      5�      �� 5�      
�������$	 0.5Q�5�      $��2q�5�      $ 5��5�      $��10, 0, 10, 0q�5�      ._�5�      �� .+�5�      �� $��
Semester: ��6"   $��20(�5�   "   $
	 True��5�   "   �� 5�      -   5         ��Name$ semsLB��5�   "   ${�False��5�   "   5�      5�      �� 5�      
�������$	 0.5Q�5�      $��2q�5�      $ 5��5�      $��10, 0, 10, 0q�5�      ._�5�      �� .+�5�      �� $��
Locations ��6"   $��20(�5�   "   $
	 True��5�   "   �� 5�      -   5        $ locationsLB��5�   "   ${�False��5�   "   5�      5�      5�      5�      �� 5�      $ 
Horizontal=�6   $��0, 0, 0, 15q�62   .+�5�      �� 
�������$	 0.5Q�5�      $��2q�5�      $ 5��5�      $��10, 0, 10, 0q�5�      ._�5�      �� .+�5�      �� $��
Subjects: ��6"   $��20(�5�   "   $
	 True��5�   "   �� 5�      -   5        $ 
subjectsLB��5�   "   ${�False��5�   "   5�      5�      �� 5�      
�������$	 0.5Q�5�      $��2q�5�      $ 5��5�      $��10, 0, 10, 0q�5�      ._�5�      �� .+�5�      �� $��Enrolled Students: ��6"   $��20(�5�   "   $
	 True��5�   "   �� 5�      -   5        $ enrolledStudsLB��5�   "   ${�False��5�   "   5�      5�      5�      5�      5�      � 5�   
   $��0��6   $��3��6   $��3��63   $��	20 0 20 0q�5�      .+�5�      �� -	   5         ��Name$ 	goBackBtn��5�      $��Go Back��5�      $
��Left=�5�      $��Center=�5�      $��10q�5�      5�      �� 5�      -
   5        $ 	enrollBtn��5�      $��Enroll��5�      $��Center=�5�      $��Center=�5�      $��10q�5�      5�      5�      5�      5�      