(* Homework3 Simple Test*)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw3provided.sml";

(* only_capitals *)
val test1 = only_capitals ["A","B","C"] = ["A","B","C"]

val test1_1 = only_capitals []              = []
val test1_2 = only_capitals ["a", "b", "c"] = []


(* longest_string1 *)
val test2 = longest_string1 ["A","bc","C"] = "bc"

val test2_1 = longest_string1 []                     = ""
val test2_2 = longest_string1 [""]                   = ""
val test2_3 = longest_string1 ["A", "bc", "C", "de"] = "bc"
val test2_4 = longest_string1 ["A", "B", "C", "D"]   = "A"


(* longest_string2 *)
val test3 = longest_string2 ["A","bc","C"] = "bc"

val test3_1 = longest_string2 []                     = ""
val test3_2 = longest_string2 [""]                   = ""
val test3_3 = longest_string2 ["A", "bc", "C", "de"] = "de"
val test3_4 = longest_string2 ["A", "B", "C", "D"]   = "D"


(* longest_string3 *)
val test4a= longest_string3 ["A","bc","C"] = "bc"

val test4a_1 = longest_string1 []                     = ""
val test4a_2 = longest_string1 [""]                   = ""
val test4a_3 = longest_string1 ["A", "bc", "C", "de"] = "bc"
val test4a_4 = longest_string1 ["A", "B", "C", "D"]   = "A"

(* longest_string4 *)
val test4b= longest_string4 ["A","B","C"] = "C"

val test4b_1 = longest_string2 []                     = ""
val test4b_2 = longest_string2 [""]                   = ""
val test4b_3 = longest_string2 ["A", "bc", "C", "de"] = "de"
val test4b_4 = longest_string2 ["A", "B", "C", "D"]   = "D"


(* longest_capitalized *)
val test5 = longest_capitalized ["A","bc","C"] = "A";

val test5_1 = longest_capitalized []                = "";
val test5_2 = longest_capitalized ["a","bc","c"]    = "";
val test5_3 = longest_capitalized ["A","bc","C"]    = "A";
val test5_4 = longest_capitalized ["AB","bc","Ab"]  = "AB"
val test5_5 = longest_capitalized ["ab","BB","Abc"] = "Abc"


(* rev_string *)
val test6 = rev_string "abc" = "cba";

val test6_1 = rev_string "" = "";
val test6_2 = rev_string "a" = "";


(* first_answer *)
val test7 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4

fun f1 n = if n = 6 then NONE else SOME n
val test7_1 = first_answer f1 [1] = 1
val test7_2 = first_answer f1 [6, 6, 3, 6] = 3
val test7_3 = first_answer f1 [3, 4, 5, 6] = 3
val test7_4 = (first_answer f1 []; false) handle NoAnswer => true
val test7_5 = (first_answer f1 [6, 6, 6, 6]; false) handle NoAnswer => true

(* all_answers *)
val test8 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE

fun f2 n = if n = 6 then NONE else SOME [n]
val test8_1 = all_answers f2 [] = SOME []
val test8_2 = all_answers f2 [1] = SOME [1]
val test8_2a = all_answers f2 [1, 1] = SOME [1, 1]
val test8_3 = all_answers f2 [1, 2, 3] = SOME[3, 2, 1]
val test8_4 = all_answers f2 [1, 2, 6, 3] = NONE


(* count_wild_cards *)
val test9a = count_wildcards Wildcard = 1

val test9a_1 = count_wildcards (Variable "foo") = 0
val test9a_2 = count_wildcards (TupleP [Variable "foo", Wildcard, Variable "bar", Wildcard]) = 2
val test9a_3 = count_wildcards (ConstructorP("foo", TupleP[Wildcard, Variable "bar"])) = 1
val test9a_4 = count_wildcards (ConstP 17) = 0
val test9a_5 = count_wildcards UnitP = 0

(* count_wild_cards_and_variable_lenghts *)
val test9b = count_wild_and_variable_lengths (Variable("a")) = 1

val test9b_1 = count_wild_and_variable_lengths Wildcard = 1
val test9b_2 = count_wild_and_variable_lengths (Variable "foo") = 2
val test9b_3 = count_wild_and_variable_lengths UnitP = 0
val test9b_4 = count_wild_and_variable_lengths (ConstructorP("foo", TupleP[Wildcard, Variable "bar"])) = 3
val test9b_5 = count_wild_and_variable_lengths (TupleP [Wildcard, Variable "foo"]) = 4;

(* count_some_var *)
val test9c = count_some_var ("x", Variable("x")) = 1;

val test9c_1 = count_some_var("hi", Wildcard) = 0
val test9c_2 = count_some_var("hi", (Variable "hi")) = 1
val test9c_3 = count_some_var("hi", UnitP) = 0
val test9c_4 = count_some_var("hi", TupleP[Wildcard, Variable "hi", Variable "ha"]) = 1
val test9c_5 = count_some_var("hi", ConstructorP("hi", TupleP[Wildcard, Variable "hi", TupleP[Variable "hi", Variable "ho"]])) = 2

(*
val test10 = check_pat (Variable("x")) = true

val test11 = match (Const(1), UnitP) = NONE

val test12 = first_match Unit [UnitP] = SOME []
*)

