fun read fl =
    let
        fun readint input =
        Option.valOf (TextIO.scanStream (Int.scan   StringCvt.DEC) input);
        val instream = TextIO.openIn fl
        val n = readint instream
        val _ = TextIO.inputLine instream
        fun readInts 0 acc = acc
        | readInts i acc = readInts (i - 1) (readint instream :: acc);
        fun reverse (xs : int list) =
            if null xs
            then []
            else reverse(tl xs) @ [hd xs]
    in
        (n,reverse(readInts n []))
    end

fun left(t : int, b : int, dig : int) =
    if t = 0 then true
    else if t < b then t = dig
    else if t mod b = dig then left(t div b, b, dig)
    else false

fun check(t : int, b : int) =
    if left(t, b, t mod b) = true then b
    else check(t, b+1)

fun base t =
    if t < 3 then 2
    else check(t, 2)

fun minbases [] = []
|   minbases (h::t) =
    let
        val i = base h
    in
        (i:: minbases t)
    end
