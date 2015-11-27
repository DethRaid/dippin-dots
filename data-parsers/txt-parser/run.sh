#!/bin/bash

#ruby txt_parser.rb ../../data/txt/2015_Undergrad_Course_Descriptions.txt ../../data/txt/2016_Undergrad_Course_Descriptions.txt
ruby txt_parser.rb ../../data/txt/2014_Undergrad_Course_Descriptions.txt ../../data/txt/2015_Undergrad_Course_Descriptions.txt > 2014-15_differences.txt
ruby txt_parser.rb ../../data/txt/2012_Undergrad_Course_Descriptions.txt ../../data/txt/2013_Undergrad_Course_Descriptions.txt > 2012-13_differences.txt

