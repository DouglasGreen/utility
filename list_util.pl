%% <module> Utility predicates for lists.
%
% @author Douglas S. Green
% @license GPL

:- module(list_util, [
        get_list_chunks/3,
        get_list_counts/2,
        get_list_slice/4,
        get_list_slice/6
    ]
).

%! get_list_chunks(+Items, +Length, -Chunks) is det.
% Separate a list into chunks of the given length.
get_list_chunks(Items, Length, [Chunk|Chunks]) :-
    Length > 0,
    length(Chunk, Length),
    append(Chunk, Rest, Items),
    Rest \= [],
    !,
    get_list_chunks(Rest, Length, Chunks).
get_list_chunks(Items, Length, [Items]) :-
    Length > 0,
    length(Items, Left),
    between(1, Length, Left).
get_list_chunks([], _, []).

:- begin_tests(get_list_chunks).

test(get_list_chunks) :-
    \+ get_list_chunks([a, b, c], 0, _),
    get_list_chunks([], _, []),
    get_list_chunks([a, b, c], 1, [[a], [b], [c]]),
    get_list_chunks([a, b, c], 2, [[a, b], [c]]),
    get_list_chunks([a, b, c], 3, [[a, b, c]]).

:- end_tests(get_list_chunks).

%! get_list_counts(+Items, -Counts) is det.
% Count a list by pairs.
get_list_counts(Items, Counts) :-
    msort(Items, Sorted),
    clumped(Sorted, Counts).

:- begin_tests(get_list_counts).

test(get_list_counts) :-
    get_list_counts([], []),
    get_list_counts([a, b], [a-1, b-1]),
    get_list_counts([b, a], [a-1, b-1]),
    get_list_counts([a, b, a], [a-2, b-1]),
    get_list_counts([a, b, a, c, b], [a-2, b-2, c-1]).

:- end_tests(get_list_counts).

%! get_list_slice(+Items, +Offset, +Length, -Slice) is det.
% Get a slice of a list.
get_list_slice(Items, Offset, Length, Slice) :-
    get_list_slice(Items, Offset, Length, _, Slice, _).

%! get_list_slice(+Items, +Offset, +Length, -Prefix, -Slice, -Suffix) is det.
% Get a slice of a list including the prefix and suffix.
get_list_slice(Items, Offset, Length, Prefix, Slice, Suffix) :-
    Length >= 0,
    length(Slice, Length),
    PrefixLength is Offset - 1,
    length(Prefix, PrefixLength),
    append([Prefix, Slice, Suffix], Items),
    !.

:- begin_tests(get_list_slice).

test(get_list_slice) :-
    \+ get_list_slice([], 1, 1, _),
    get_list_slice([a], 1, 1, [a]),
    get_list_slice([a, b, c], 1, 1, [a]),
    get_list_slice([a, b, c], 1, 2, [a, b]),
    get_list_slice([a, b, c], 1, 3, [a, b, c]),
    get_list_slice([a, b, c], 2, 1, [b]),
    get_list_slice([a, b, c], 2, 2, [b, c]),
    get_list_slice([a, b, c], 3, 1, [c]),
    \+ get_list_slice([], 1, 4, _),
    \+ get_list_slice([], 1, 1, _, _, _),
    get_list_slice([a], 1, 1, [], [a], []),
    get_list_slice([a, b, c], 1, 1, [], [a], [b, c]),
    get_list_slice([a, b, c], 1, 2, [], [a, b], [c]),
    get_list_slice([a, b, c], 1, 3, [], [a, b, c], []),
    get_list_slice([a, b, c], 2, 1, [a], [b], [c]),
    get_list_slice([a, b, c], 2, 2, [a], [b, c], []),
    get_list_slice([a, b, c], 3, 1, [a, b], [c], []),
    \+ get_list_slice([], 1, 4, _, _, _).

:- end_tests(get_list_slice).
