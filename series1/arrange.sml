fun read fl =
    let
        fun readint input =
        Option.valOf (TextIO.scanStream (Int.scan   StringCvt.DEC) input);
        val instream = TextIO.openIn fl
        val q = readint instream
        val n = 2*q+1
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

datatype t = NULL | node of int * t * t
fun min(a : int, b : int) = if a < b then a else b


fun fix (node(v, l, r), q : int list, left : bool) =
    if left = true then (
        if hd q = 0 then
        fix(node(v, l, r), tl q, false)        
        else (
            let
            val new_node = node(hd q, NULL, NULL)
            val (fix_new_node, fix_n) = fix(new_node, tl q, true)
            val this_node = node(v, fix_new_node, r)
            in
            fix(this_node, fix_n, false)
            end
        )
    )
    else (
        if hd q = 0 then (
            (node(v, l, r), tl q)
        )
        else (
            let
            val new_node = node(hd q, NULL, NULL)
            val (fix_new_node, fix_n) = fix(new_node, tl q, true)
            val this_node = node(v, l, fix_new_node)
            in
            (this_node, fix_n)
            end
        )
    )




fun help(node(a, b, c)) =
    if b = NULL then (
        if c = NULL then a
        else if help(c) < a then help(c)
        else a
    )
    else if c = NULL then (
        if help(b) > a then a
        else help(b)
    )
    else if help(c) < help(b) then help(c)
    else help(b)


fun swap (tr : t, i : int) =
    if tr = NULL then (tr, i)
    else
    let
    val node(a, b, c) = tr
    val (stas, ab) = swap(b, a)
    val (sta, cd) = swap(c, a)
    val nodes =
    if ab > cd then node(a, sta, stas) else node(a, stas, sta)
    val noumero = min(ab, cd)
    in
    (nodes, noumero)
    end


fun inorder(tr : t) =
    if tr = NULL then
    print("")
    else
    let
    val node(a, b, c) = tr
    in
    inorder(b);
    print(Int.toString(a)^" ");
    inorder(c)
    end


fun arrange fl =
    let
        val (n, q) = read fl;
        val a = node(hd q, NULL, NULL);
        val q = tl q;
        val (root, no_one) = fix(a, q, true);
        val (stas, tab) = swap(root, 0)
    in
    inorder(stas);
    print("\n")
    end
