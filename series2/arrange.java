import java.io.File;
import java.util.Scanner;

public class arrange {
    static Scanner scanner;
    static int count;

    static class node {
        int val;
        node left, right;
        public node(int val) {
            this.val = val;
            this.left = null;
            this.right = null;
        }
    }

    public static void create(node t, boolean left) {
        if (count == 0) return;
        int temp = scanner.nextInt();
        if (temp == 0) {
            if (left) create(t, false);
            return;
        }

        count--;

        if (left) {
            t.left = new node(temp);
            create(t.left, true);
            create(t, false);
        } else {
            t.right = new node(temp);
            create(t.right, true);
        }
    }

    public static void swap(node n) {
        node temp = n.left;
        n.left = n.right;
        n.right = temp;
    }

    public static int fix(node t) {
        int l, r;
        if (t.left != null) l = fix(t.left);
        else l = t.val;
        if (t.right != null) r = fix(t.right);
        else r = t.val;
        if (l > r) {
            swap(t);
            return r;
        }
        return l;
    }

    static String s = "";

    public static void inorder(node t) {
        if (t == null) return;
        inorder(t.left);
        s = s + t.val + " ";
        inorder(t.right);
    }

    static node head;

    public static void main(String[] args) {
        String f = args[0];
        File file = new File(f);

        try (Scanner scanner = new Scanner(file)) {
            arrange.scanner = scanner;
            count = scanner.nextInt();
            head = new node(scanner.nextInt());
            count--;
            create(head, true);
            int t = fix(head);
            inorder(head);
            System.out.println(s);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
