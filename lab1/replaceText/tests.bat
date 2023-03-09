set PROGRAM="%~1"
set PREPARED_TESTS_PATH = prepared_tests
set OUT="%TEMP%\result.txt"

rem Invalid args count
%PROGRAM% one_line.txt invalid_args_result.txt someone > %OUT%
fc %OUT% prepared_tests\invalid_args_result_prepared.txt || goto err

rem ONE LINE
rem replace one word
%PROGRAM% one_line.txt %OUT% someone anything || goto err
fc %OUT% prepared_tests\one_line_word_result_prepared.txt || goto err

rem replace string
%PROGRAM% one_line.txt %OUT% "replace someone" anything || goto err
fc %OUT% prepared_tests\one_line_string_result_prepared.txt || goto err

rem replace numbers
%PROGRAM% one_line.txt %OUT% 1231234 ! || goto err
fc %OUT% prepared_tests\one_line_numbers_result_prepared.txt || goto err

rem replace empty string
%PROGRAM% one_line.txt %OUT% "" anything || goto err
fc %OUT% prepared_tests\one_line_empty_string_result_prepared.txt || goto err

rem replace word with empty string
%PROGRAM% one_line.txt %OUT% anything "" || goto err
fc %OUT% prepared_tests\one_line_with_empty_string_result_prepared.txt || goto err

rem MULTI LINE
rem replace one word
%PROGRAM% multiline.txt %OUT% someone anything || goto err
fc %OUT% prepared_tests\multiline_word_result_prepared.txt || goto err

rem replace string
%PROGRAM% multiline.txt %OUT% "replace someone" anything || goto err
fc %OUT% prepared_tests\multiline_string_result_prepared.txt || goto err

rem replace empty string
%PROGRAM% multiline.txt %OUT% "" anything || goto err
fc %OUT% prepared_tests\multiline_empty_string_result_prepared.txt || goto err

rem replace word with empty string
%PROGRAM% multiline.txt %OUT% anything "" || goto err
fc %OUT% prepared_tests\multiline_with_empty_string_result_prepared.txt || goto err

rem LARGE FILE
rem replace one word
%PROGRAM% big.txt %OUT% small ANYTHINGG || goto err
fc %OUT% prepared_tests\large_file_word_result_prepared.txt || goto err

rem replace string
%PROGRAM% big.txt %OUT% "legal small print" ANYTHINGG || goto err
fc %OUT% prepared_tests\large_file_string_result_prepared.txt || goto err

rem EMPTY FILE
rem Empty file: replace one word
%PROGRAM% empty_file.txt %OUT% test anything || goto err
fc %OUT% prepared_tests\empty_file_result_prepared.txt || goto err

echo Program testing succeeded
exit 0

:err
echo Program testing failed
exit 1