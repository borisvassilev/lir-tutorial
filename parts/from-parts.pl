main :-
    current_prolog_flag(argv, [N|_]),
    atom_number(N, X),
    numlist(1, X, Nums),
    maplist(num_name, Nums, Names),
    concat(Names).

num_name(X, X-Name) :-
    atomics_to_string([X,"-p.lir"], Name).

concat(Names) :-
    forall(member(X-N, Names),
        (   one(X, N),
            format("\n----\n\n")
        )),
    length(Names, Len),
    (   Len >= 3
    ->  setup_call_cleanup(open("last.lir", read, In),
            (   read_string(In, _, Str),
                format("~s", [Str])
            ),
            close(In))
    ).

one(X, FN) :-
    setup_call_cleanup(open(FN, read, In),
        (   read_string(In, _, Str),
            links(X, Links),
            format("~s\n~s\n", [Str, Links])
        ),
        close(In)).

links(ID, Links) :-
    Repo = "https://github.com/borisvassilev/lir-tutorial/blob/master",
    Pages = "https://borisvassilev.github.io/lir-tutorial",
    atomics_to_string(
        ["Get \n[source](", Repo, "/docs/", ID, "/anagrams.lir)\n",
         "and [final document](", Pages, "/", ID, "/anagrams.html)\n"],
        Links).
