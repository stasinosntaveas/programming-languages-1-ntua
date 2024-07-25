import java.io.File;
import java.util.Scanner;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Vector;

public class Moves {

    static int n;
    static int[][] grid;
    static Boolean[][] visited;

    static int [] dirx = {
                    -1, 0, 1,
                    -1,    1,
                    -1, 0, 1};

    static int [] diry = {
                    -1,-1,-1,
                     0,    0,
                     1, 1, 1};

    static String[] dir = {"NW", "N", "NE", "W", "E", "SW", "S", "SE"};

    static class t { // utple
        int x;
        int y;
        Vector<String> v;
        public t(int x, int y, Vector<String> v) {
            this.x = x;
            this.y = y;
            this.v = v;
        }
    }
    static Queue<t> bfs = new LinkedList<>();

    public static Vector<String> concat(Vector<String> v, String s) {
        Vector<String> w = new Vector<>(v);
        w.add(s);
        return w;
    }

    public static void cout(Vector<String> v) {
        String s = "[";
        for (int i = 0; i < v.size()-1; ++i) {
            s += v.get(i) + ",";
        }
        if (v.size() > 0) s += v.lastElement() + "]";
        System.out.println(s);
    }

    public static void main(String[] args) {
        String f = args[0];
        File file = new File(f);
        
        
        try (Scanner scanner = new Scanner(file)) {
            n = scanner.nextInt();

            grid = new int[n][n];
            visited = new Boolean[n][n];

            for (int i = 0; i < n; i++) {
                
                for (int j = 0; j < n; j++) {
                    grid[i][j] = scanner.nextInt();
                    visited[i][j] = false;
                }
            }

            bfs.offer(new t(0,0,new Vector<>()));
            Boolean found = false;

            while (!bfs.isEmpty() && !found) {
                t temp = bfs.poll();
                if (temp.x  == n-1 && temp.y == n-1) {
                    cout(temp.v);
                    found = true;
                    break;
                }

                if (visited[temp.y][temp.x] == false) {
                    visited[temp.y][temp.x] = true;
                    for (int i = 0; i < 8; ++i) {
                        int x = temp.x +dirx[i];
                        int y = temp.y +diry[i];
                        if (x >= 0 && x < n && y >= 0 && y < n && grid[temp.y][temp.x] > grid[y][x]) {
                            bfs.offer(new t(x, y, concat(temp.v, dir[i])));
                        }
                        // else if (x < 0 || x > n || y < 0 || y >= n) System.out.println(i+1 + ". x = " +x+ ", y = " + y);
                        // else if (x == 5 && y == 1) System.out.println(i+1 + ". y, x = "+ y + " "+ x + " " + grid[temp.y][temp.x] + " > "+grid[x][y]+" && " + visited[temp.y][temp.x] + " == false");
                        // else System.out.println(i+1 + ". x = " +x+ ", y = " + y);
                    }
                }
            }

            if (!found) System.out.println("IMPOSSIBLE");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
