   M S B A M L   `   `   `  ����E  ATafeMoodle, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null1clr-namespace:TafeMoodle.ViewTafeMoodle.View  5           TafeMoodle.View.SubjectAdd   5      \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      /localclr-namespace:TafeMoodle.View     5        N� Title$  
SubjectAdd��5	      .��5      �  � ColumnDefinitions 5   
   �� 5      $��* �6   �� 5      $��* �6    � RowDefinitions 5   
   �� 5      $��75 �6   �� 5      $��* �6   �� 5      $	��100 �6   .+�5   
   �� $��4��6   $��10��5       J� Opacity$	 0.8Q�5      ��5      �� 5      .��5      �  � Color$ #7be9f6��6#    � Offset$	 0.0Q�63   � 5      $ #f083da��6#   $ 1Q�63   5      5      �� 5"   
   $��0��6   $��2��6$   $��0��68   $��Add New Subject��5#      $��30(�5$      
�������$��Center=�5&      $��	0 10 0 10q�5'      �� 5)   
   $��1��6   $��2��6#   .+�5*      ��  �� Orientation$ 
Horizontal=�6   $��0, 0, 0, 15q�62   .+�5+      �� 
�������$	 0.5Q�5,      $��2q�5-       �� CornerRadius$ 5��5.      $��10, 0, 10, 0q�5/      ._�50      �� .+�51      �� $
��ID: ��6"   $��20(�52   "    �� 
IsReadOnly$
 True��53   "   �� 54      -   5        	 ��Name$	 subIDTxt��5<   "   $��20(�54   "   $	��Top=�55   "   $��Center=�56   "   
������ $
��Left=�58   "   $	 0.5Q�59   "   $��25��5:   "   $
 True��5;   "   5<   "   5=      5>      �� 5@      
�������$	 0.5Q�5A      $��2q�5B      $ 5��5C      $��10, 0, 10, 0q�5D      ._�5E      �� .+�5F      �� $��	Subject: ��6"   $��20(�5G   "   $
 True��5H   "   �� 5I      -   5        $	 
subNameTxt��5P   "   $��20(�5I   "   $	��Top=�5J   "   $��Center=�5K   "   
������ $
��Left=�5M   "   $	 0.5Q�5N   "   $��25��5O   "   5P   "   5Q      5R      �� 5S      
�������$	 0.5Q�5T      $��2q�5U      $ 5��5V      $��10, 0, 10, 0q�5W      ._�5X      �� .+�5Y      �� $��	Unit List��6"   $��20(�5Z   "   $
 True��5[   "   �� 5\      -   5        
 ��Name$
 unitListStackPanel��5\   %   5]      5^      �� 5`      
�������$	 0.5Q�5a      $��2q�5b      $ 5��5c      $��10, 0, 10, 0q�5d      ._�5e      �� .+�5f      �� $��Teacher List��6"   $��20(�5g   "   $
 True��5h   "   �� 5i      -   5        $
 teachersStack��5i   %   5j      5k      5m      5o      � 5r   
   $��0��6   $��3��6   $��3��63   $��	20 0 20 0q�5s      .+�5u      �� -   5         ��Name$ 	goBackBtn��5v      $��Go Back��5u      $
��Left=�5w      $��Center=�5x      $��10q�5y      5z      �� 5|      -   5        $ 	CancelBtn��5|      $��Cancel Record��5}      $��Center=�5~      $��Center=�5      $��10q�5�      5�      �� 5�      -   5        $ saveBtn��5�      $
��Save��5�      $��Right=�5�      $��Center=�5�      $��10q�5�      5�      5�      5�      5�      