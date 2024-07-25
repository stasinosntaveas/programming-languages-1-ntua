fun read fl =
    let
        fun readint input =
        Option.valOf (TextIO.scanStream (Int.scan   StringCvt.DEC) input);
        val instream = TextIO.openIn fl
        val n = readint instream
        val _ = TextIO.inputLine instream
        fun readInts 0 acc = acc
        | readInts i acc = readInts (i - 1) (acc @ [readint instream])
        fun readLines 0 acc = acc
        | readLines i acc = readLines (i - 1) (acc @ [readInts n []])
    in
        (n,readLines n [])
    end

fun create_row n = Vector.tabulate (n, fn _ => false)
fun vect n = Vector.tabulate (n, fn _ => create_row n)

fun mod_v v y x =
    Vector.update(v, y, Vector.update(Vector.sub(v, y), x, true))

fun cout q =
    let
        val (a, b) = (hd q, tl q)
    in
        if null b then a ^ "]\n"
        else a ^ "," ^ cout b
    end

fun search (n : int, l : int list list, bmap : bool vector vector, qy : int list, qx : int list, qq : string list list, qp : int list) =
    if null qx then
        []
    else
        let
            val (y, x, q, prev) = (hd qy, hd qx, hd qq, hd qp)
        in
            if x < 0 orelse x > n orelse y < 0 orelse y > n then
                search(n, l, bmap, tl qy, tl qx, tl qq, tl qp)
            else
                let
                    val cur = List.nth(List.nth(l, y), x)
                in
                    if Vector.sub(Vector.sub(bmap, y), x) orelse cur >= prev then
                        search(n, l, bmap, tl qy, tl qx, tl qq, tl qp)
                    else if x = n andalso y = n then
                        q
                    else
                        let
                            val (bmap, qy, qx, qq, qp) = (mod_v bmap y x, tl qy @ [y-1, y-1, y-1, y, y, y+1, y+1, y+1], tl qx @ [x-1, x, x+1, x-1, x+1, x-1, x, x+1], tl qq @ [q @ ["NW"], q @ ["N"], q @ ["NE"], q @ ["W"], q @ ["E"], q @ ["SW"], q @ ["S"], q @ ["SE"]], tl qp @ [cur, cur, cur, cur, cur, cur, cur, cur])
                        in
                            search(n, l, bmap, qy, qx, qq, qp)
                        end
                end
        end

fun moves fl =
    let
        val (n, l) = read fl
    in
        if n < 2 then
            print("[]\n")
        else
            let
                val (t, bool_map, first) = (n - 1, vect n, List.nth(List.nth(l, 0), 0) + 1)
                val path = search(t, l, bool_map, [0], [0], [[]], [first])
            in
                if null path then
                    print("IMPOSSIBLE\n")
                else
                    print("[" ^ cout path)
            end
    end
