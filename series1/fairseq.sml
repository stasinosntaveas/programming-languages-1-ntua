fun read fl =
    let
        fun readint input =
        Option.valOf (TextIO.scanStream (Int.scan   StringCvt.DEC) input);
        val instream = TextIO.openIn fl
        val n = readint instream
        val _ = TextIO.inputLine instream
        fun readInts 0 acc = acc 
        | readInts i acc = readInts (i - 1) (readint instream :: acc);
    in
        (n,readInts n [])
    end

fun abs (a : int) = if a > 0 then a else ~a
fun min (a : int, b : int) : int = if a < b then a else b

fun nth (xs : int list, i : int) =
    if i = 0
    then hd xs
    else nth (tl xs, i-1)

fun sum (xs : int list) =
    if null xs
    then 0
    else hd xs + sum(tl xs)

fun r(l : int list, i : int, j : int, s : int) =
    if j = length l then abs(s)
    else min(r(l, i, j+1, s-2*nth(l, j)), abs(s))

fun f(l : int list, i : int, j : int, s : int) =
    if j = length l then s
    else
    min(f(l, i+1, j+1, s), r(l, i, j, s))



fun fairseq fl =
    let
    val (n, l) = read fl;
    val (tempor) = f(l, 0, 0, sum(l))
    val tempora = min(abs(tempor), abs(sum(l)))
    in
    print(Int.toString(tempora)^"\n")
    end
