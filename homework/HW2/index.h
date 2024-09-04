#ifndef INDEX_H_
#define INDEX_H_
#include <iostream>
#include <vector>
using namespace std;

//implement by node
class Node {
    public:
        // constructor
        Node();

        bool isLeaf;
        vector<int> keys;

        // for internal nodes
        vector<Node*> ptr_to_children;  // record children's position

        // for leafnode
        Node* link_to_next_node_for_leaf;    // connect to next node
        vector<int> values;         // b+ tree record values in leaf

        friend class BP_tree;
};

//construct a tree made up of nodes
class BP_tree {
    private:
        Node* root;            // ptr to bptree root
        int num_child_of_internal;   // num of child of internal node
        int num_node_of_leaf;        // num of nodes in leaf

        // build bptree
        void insert_leaf_without_overflow(Node* current, int key, int value);       // insert data into leaf
        void insert_key_to_Internal(int key_insert, Node** current, Node** child);  
                /* 把 key 往上提至 internal node，這裡的 current 是把 parent 丟進去做*/
        Node** find_parent(Node* current, Node* child);       // call by insert_key_to_Internal
        
    public:
        BP_tree();
        BP_tree(int internal_degree, int leaf_degree);
        Node* getRoot();
        int get_num_child_of_internal();
        int get_num_node_of_leaf();

        // build bptree
        void insert(int key, int value);        // call the functions in private 

        // Query by key
        int search_by_key(int key); 

        //Query by range of key
        Node* find_node_in_range(int key);
};

class Index{
    private:
        int order;
        BP_tree * bp_tree;
    public:
        //constructor index(num_rows, key, value)
        Index(int, vector<int>, vector<int>);  

        //Query by key
        void key_query(vector<int>);

        //Query by range of key
        void range_query(vector<pair<int, int> >);

        //Free memory
        void clear_index();
        void delete_node_recursion(Node*);

        //destructor
        ~Index(); 
};
#endif