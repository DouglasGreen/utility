%% <module> Utility predicates for strings.
%
% @author Douglas S. Green
% @license GPL

:- module(list_util, [
        is_string_part/2
    ]
).

%! is_string_part(+String, +Part) is semidet.
% Check if a string has a part (substring).
is_string_part(String, Part) :-
    sub_string(String, _, _, _, Part),
    !.

:- begin_tests(is_string_part).

test(is_string_part) :-
    is_string_part("abc", "a"),
    is_string_part("abc", "b"),
    is_string_part("abc", "c"),
    is_string_part("abc", "ab"),
    is_string_part("abc", "bc"),
    is_string_part("abc", "abc"),
    \+ is_string_part("abc", "d"),
    \+ is_string_part("abc", "abcd").

:- end_tests(is_string_part).
