   M S B A M L   `   `   `  ����E  ATafeMoodle, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null1clr-namespace:TafeMoodle.ViewTafeMoodle.View  5          TafeMoodle.View.LoginPage   5      \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      /localclr-namespace:TafeMoodle.View     5      c _MahApps.Metro.IconPacks.Core, Version=4.0.0.0, Culture=neutral, PublicKeyToken=0c0d510f9915137ag cMahApps.Metro.IconPacks.Material, Version=4.0.0.0, Culture=neutral, PublicKeyToken=0c0d510f9915137a?	iconPacks-http://metro.mahapps.com/winfx/xaml/iconpacks   5        N� Title$  	LoginPage��5
      .��5      �  � RowDefinitions 5   
   �� 5      �� 5       � ColumnDefinitions 5   
   �� 5      �� 5      �� 5      .+�5   
   ��  �� CornerRadius$ 10��6   $��2��6#   $��3��5      ��5      �� 5      .��5      �  � Color$ #7be9f6��6#    � Offset$	 0.0Q�63   � 5      $ #f083da��6#   $ 1Q�63   5      5      �� 5    
   $��1��6   $��2��5!      $��Center=�5"      .+�5#      �� $��Center=�6   .+�5$      �� $��../Images/TAFE_Logo.png��6   $	��200��69   $��5q�6E   �� 5%      $��Sign In��6   $��Light"�5&      $��	Helvetica)�5'      $��22(�5(      
�������$��Center=�5*      $��10q�5+      5,      �� 5-      .+�5.      �� 
������� J� Opacity$	 0.5Q�5/      $��2q�50      $��Center=�51      $��Center=�52      $ 5��53      ._�54      ��  �� Orientation$ 
Horizontal=�6!   $��Center=�55   !   .+�56      .  (MahApps.Metro.IconPacks.PackIconMaterial     Kind$ Account=�65   $��Center=�57   5   
�������$��20, 0, 0, 0q�59   5   �� 5:      -   5        	 ��Name$	 usernameInput��5:   "   $��	Helvetica)�5;   "   $��Light"�5<   "   $��20(�5=   "   $	��Top=�5>   "   $��Center=�5?   "   
������ $	��235��5A   "   $
��Left=�5B   "   $	 0.5Q�5C   "   $��25��5D   "   $��15, 0, 0, 0q�5E   "   5F      5G      �� 5H      
�������$	 0.5Q�5I      $��2q�5J      $��Center=�5K      $��Center=�5L      $ 5��5M      $��0, 20, 0, 0q�5N      ._�5P      �� $ 
Horizontal=�6!   $��Center=�5Q   !   .+�5R        $ FormTextboxPassword=�65   $��Center=�5S   5   
�������$��20, 0, 0, 0q�5U   5   G� 5V      -   5        
 G�Name$
 passwordInput��5V   &   $��	Helvetica)�5W   &   $��Light"�5X   &   $��20(�5Y   &   $	��Top=�5Z   &   $��Center=�5[   &   
�������
������ $	��235��5^   &   $
��Left=�5_   &   $	 0.5Q�5`   &   $��25��5a   &   $��15, 0, 0, 0q�5b   &   5c      5d      �� 5f      $ 
Horizontal=�6   $��0, 50, 0, 0q�5g      $��Center=�5h      .+�5i      �� -   5        $��loginBtn��5i      $	��100��5k      $��40��6)   $��LOGIN��5l      $��0, 0, 20, 0q�5m      �� 5n      -   5        $��registerBtn��5n      $	��100��5p      $��40��6)   $��REGISTER��5q      5r      5s      5t      5u      5v      