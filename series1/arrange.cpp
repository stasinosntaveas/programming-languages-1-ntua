#include <bits/stdc++.h>
using namespace std;

struct TreeNode {
    int val;
    TreeNode *left, *right;
    TreeNode() : val(0), left(NULL), right(NULL) {}
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
    
};

void create(TreeNode* t, int& count, ifstream& file, bool left) {
    if (count == 0) return;
    int temp;
    file >> temp;
    if (temp == 0) {
        if (left) create(t, count, file, false);
        return;
    }
    count--;
    if (left) {
        t->left = new TreeNode(temp);
        create(t->left, count, file, true);
        create(t, count, file, false);
        return;
    }
    t->right = new TreeNode(temp);
    create(t->right, count, file, true);
};


TreeNode* temp;

int fix(TreeNode* t) {
    int l, r;
    if (t->left) l = fix(t->left);
    else l = t->val;
    if (t->right) r = fix(t->right);
    else r = t->val;
    if (l > r) {
        swap(t->left, t->right);
        return r;
    }
    return l;
}

string s = "";
void inorder(TreeNode* t) {
    if (!t) return;
    inorder(t->left);
    s += to_string(t->val) + " ";
    inorder(t->right);
}



int main(int argc, char* argv[]) {
    if (argc != 2) {
        cerr << "Error: Invalid number of arguments. Expected 2 arguments.\n";
        exit(EXIT_FAILURE);
    }

    string filename = argv[1];
    
    ifstream file(filename);

    if (!file.is_open()) {
        cerr << "Error: Unable to open file " << filename << "\n";
        return 1;
    }
    int count;
    file >> count;
    int t;
    file >> t;
    temp = new TreeNode(t);
    create(temp, count, file, true);
    t = fix(temp);
    inorder(temp);
    s.pop_back();
    cout << s;
    return 0;
}
