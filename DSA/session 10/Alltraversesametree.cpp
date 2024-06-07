#include <bits/stdc++.h>
using namespace std;

class Node {
    public:
    int data;
    Node* left;
    Node* right;
    Node(int val) {
        this->data = val;
        this->left = NULL;
        this->right = NULL;
    }
};

class Solution{
    public:
     int findPos(int in[] , int start , int end, int key){
        for(int i=start; i<=end;i++){
            if( key == in[i]){
                return i;
            }
        }
        return -1;
    }
    
    Node* solve(int in[] , int pre[] , int n , int inOrderStart , int inOrderEnd , int &posRoot){
        if(posRoot >= n || inOrderStart  > inOrderEnd) return NULL;
        int element = pre[posRoot];
        posRoot++;
        
        Node* root = new Node(element);
        int position = findPos(in , inOrderStart , inOrderEnd, element);
    
        root->left = solve(in, pre, n , inOrderStart , position-1 ,posRoot );
        root->right= solve(in, pre, n , position+1 , inOrderEnd , posRoot );
        
        return root;
    }
    void post(Node* root, vector<int>& temp) {
        if(root==NULL) return;
        
        post(root->left, temp);
        post(root->right, temp);
        temp.push_back(root->data);
    }
    bool checktree(int preorder[], int inorder[], int postorder[], int N) 
    { 
       
       int posRoot=0;
       Node* tree =  solve( inorder , preorder , N , 0 , N-1 , posRoot );
       vector<int>temp;
       post(tree,temp);
       
       for(int i=0;i<N;i++) 
           if(temp[i]!=postorder[i]) return false;
       return true;
    } 

};