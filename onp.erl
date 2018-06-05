%%%-------------------------------------------------------------------
%%% @author Łukasz Janeczko
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 26. Mar 2018 00:11
%%%-------------------------------------------------------------------
-module(onp).
-author("Łukasz Janeczko").

%% API
-export([onp/1]).


onp(List) when is_list(List) ->
    [Result] = lists:foldl(fun rpn/2, [], string:tokens(List, " ")),
    %io:format("Hurra, no errors!~n"),
    Result.


rpn("+", [X, Y | Stack])  -> [(X + Y) | Stack];
rpn("-", [X, Y | Stack])  -> [(Y - X) | Stack];
rpn("*", [X, Y | Stack])  -> [(X * Y) | Stack];
rpn("/", [X, Y | Stack])  -> [(Y / X) | Stack];
rpn("^", [X, Y | Stack])  -> [(math:pow(Y, X)) | Stack];
rpn("pow", [X, Y | Stack])  -> [(math:pow(Y, X)) | Stack];
rpn("sqrt", [X | Stack])  -> [(math:sqrt(X)) | Stack];
rpn("sin", [X | Stack])   -> [(math:sin(X)) | Stack];
rpn("cos", [X | Stack])   -> [(math:cos(X)) | Stack];
rpn("tg", [X | Stack])    -> [(math:tan(X)) | Stack];
rpn("tan", [X | Stack])   -> [(math:tan(X)) | Stack];
rpn("ctg", [X | Stack])   -> [(1.0 / math:tan(X)) | Stack];
rpn("ln", [X | Stack])    -> [(math:log(X)) | Stack];
rpn("log2", [X | Stack])   -> [(math:log2(X)) | Stack];
rpn("log", [X | Stack])   -> [(math:log10(X)) | Stack];
rpn("log10", [X | Stack])   -> [(math:log10(X)) | Stack];
rpn("exp", [X | Stack])   -> [(math:exp(X)) | Stack];

rpn(Num, Stack)           -> [readNumber(Num) | Stack].


readNumber(Num) ->
    case string:to_float(Num) of
        {error, _} -> list_to_integer(Num);
        {Float, _} -> Float
    end.
