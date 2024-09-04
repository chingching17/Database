#include <iostream>
#include <vector>
#include <cmath>
#include <fstream>
#include <algorithm>
#include "index.h"
using namespace std;

Index::Index(int num_rows, vector<int> keys, vector<int> value)
{
    //set order
    // 算起來 order 大約在 300 在這個例子來說最好
    int temp;
    temp = int(pow(num_rows, 1/2.7));
    order = (max(4, temp)/2) * 2 + 1;
    // cout << "order: "<< order << endl;

    // # of child need to +1 by # of leaf node
    // BP_tree(int internal_degree, int leaf_degree);
    bp_tree = new BP_tree(order + 1, order);

    // insert key and value
    for(int i = 0 ; i < num_rows ; i++){
        bp_tree->insert(keys[i], value[i]);     // so hard QAQ
    }
}

void Index::key_query(vector<int> query_keys)
{
    int value = -1;
    for(int i = 0 ; i < query_keys.size() ; i++){
        value = bp_tree->search_by_key(query_keys[i]);
        query_keys[i] = value;
    }

    // output file
    fstream file;
    file.open ("key_query_out.txt", fstream::out);
    for(int i=0;i<query_keys.size();i++){
        file << query_keys[i] << endl;
    }
    file.close();

}

void Index::range_query(vector<pair<int, int> > query_pairs)
{
    // todo: 找到 range 內最大值
    /*
        情況:
        1. 找不到 key 所對應的 node
        2. 左右端的 node 為同一個
        3. 左右端的 node 不同(須用到link_to_next_node_for_leaf)
            (1) 找左邊 node value 最大
            (2) 找右邊 node value 最大
            (3) 找中間 node value 最大

        // 以下兩個 situation 合併到上述第三個情況，原本想說要做判斷
        1. 左右端的 node 在相同 leaf (不須用到link_to_next_node_for_leaf)
        2. 左右端的 node 在不同 leaf (須用到link_to_next_node_for_leaf)
    */
    int max;
    Node* leftNode;
    Node* rightNode;

    for(int i = 0 ; i < query_pairs.size() ; i++){
        max = -1;
        leftNode = bp_tree->find_node_in_range(query_pairs[i].first);
        rightNode = bp_tree->find_node_in_range(query_pairs[i].second);

        // situation 1
        if(leftNode == NULL || rightNode == NULL){
           query_pairs[i].first = -1;
        }
        // situation 2
        else if(leftNode == rightNode){
            // 找 leaf node 裡對應 key 的 index
            int left_pos = lower_bound(leftNode->keys.begin(), leftNode->keys.end(), query_pairs[i].first) - leftNode->keys.begin();
            int right_pos = upper_bound(rightNode->keys.begin(), rightNode->keys.end(), query_pairs[i].second) - rightNode->keys.begin();

            // 取得 max
            for(int j = left_pos ; j < right_pos ; j++){
                if(leftNode->values[j] > max){
                    max = leftNode->values[j];
                }
            }
            query_pairs[i].first = max;
        }
        // situation 3
        else{
            // 查找 leftNode
            int index = lower_bound(leftNode->keys.begin(), leftNode->keys.end(), query_pairs[i].first) - leftNode->keys.begin();
            for(int j = index ; j < leftNode->keys.size() ; j++){
                if(leftNode->values[j] > max){
                    max = leftNode->values[j];
                }
            }

            // 查找 rightNode
            index = upper_bound(rightNode->keys.begin(), rightNode->keys.end(), query_pairs[i].second) - rightNode->keys.begin();
            for(int j = 0 ; j < index ; j++){
                if(rightNode->values[j] > max){
                    max = rightNode->values[j];
                }
            }

            // 查找中間 leaf
            Node* middle_leaf = leftNode->link_to_next_node_for_leaf;

            /*
                停止條件
                1. 到了一個空的 leaf
                2. 到了右端的 leaf
            */
            int internalMax;
            while(middle_leaf != NULL && middle_leaf != rightNode){
                if(middle_leaf->values.size() > 0){
                    internalMax = *max_element(middle_leaf->values.begin(), middle_leaf->values.end());
                    if(internalMax > max){
                        max = internalMax;
                    }
                }
                middle_leaf = middle_leaf->link_to_next_node_for_leaf;
            }
            query_pairs[i].first = max;
        }
    }
    // cout << range_query_ans.size() << endl;

    fstream file;
    file.open("range_query_out.txt", fstream::out);
    for(int i=0;i<query_pairs.size();i++){
        file << query_pairs[i].first << endl;
    }
    file.close();
}

void Index::clear_index()
{
    delete_node_recursion(bp_tree->getRoot());
    delete bp_tree;
}

void Index::delete_node_recursion(Node* current)
{
    // if leaf
    if(current->isLeaf == true){
        delete current;
        return;
    }
    // if internal, recursive
    else{
        for(int i = 0 ; i < current->ptr_to_children.size() ; i++){
            // delete children
            delete_node_recursion(current->ptr_to_children[i]);
        }
    }
    delete current;
}

Index::~Index()
{

}

Node::Node()
{
    this->isLeaf = false;
    this->link_to_next_node_for_leaf = NULL;
}

BP_tree::BP_tree()
{
    // default
    this->root = NULL;

    // # nodes of leaf must less than # children of internal node
    this->num_child_of_internal = 5;
    this->num_node_of_leaf = 4;
}

BP_tree::BP_tree(int internal_degree, int leaf_degree)
{
    this->root = NULL;
    this->num_child_of_internal = internal_degree;
    this->num_node_of_leaf = leaf_degree;
}

Node* BP_tree::getRoot()
{
    return this->root;
}

int BP_tree::get_num_child_of_internal()
{
    return this->num_child_of_internal;
}

int BP_tree::get_num_node_of_leaf()
{
    return this->num_node_of_leaf;
}

void BP_tree::insert(int key, int value)
{
    /*todo
        //還未有 root
            1. 新增 root
        
        // 已經有 root
            1. 沒有 overflow，insert_without_overflow()
            2. 有 overflow，且不為 leaf，將中位數往上提至 parent node
            3. 有 overflow，且為 leaf，把中位數放在右邊的 leaf 中
    */

   //還未有 root
   if(root == NULL){
       root = new Node;
       root->isLeaf = true;
       root->keys.push_back(key);
       root->values.push_back(value);
       return;
   }

   // 已經有 root
   else{
       Node* current = root;
       Node* parent = NULL;

       // 尋找放入的位置，與 search_by_key 同方法
       while(current->isLeaf == false){
           // move position of parent to current
           parent = current;

           // find index to move current
           int index = upper_bound(current->keys.begin(), current->keys.end(), key) - current->keys.begin();
           current = current->ptr_to_children[index];
       }

       // insert into leaf, and not overflow
       if(current->keys.size() < num_node_of_leaf){
        //    insert_leaf_without_overflow(current, key, value);
            // 順序要寫對qqq，超級大 bug 嗚嗚嗚嗚嗚嗚
            int index = upper_bound(current->keys.begin(), current->keys.end(), key) - current->keys.begin();
            
            // 先 push 進去再改位置
            current->keys.push_back(key);
            current->values.push_back(value);

            // 如果不是在 vector 最後一位的話要改位置
            if(index != current->keys.size() - 1){

                // 將 key. value 往後移空出位置放進 index 的地方
                for(int i = current->keys.size() - 1 ; i > index ; i--){
                    current->keys[i] = current->keys[i-1];
                    current->values[i] = current->values[i-1];
                }

                // 把值放進去相對應的位置囉!
                current->keys[index] = key;
                current->values[index] = value;
            }
       }
       // insert into leaf but overflow
       else{
            // redistribute leaf
            vector<int> tmp_keys(current->keys);
            vector<int> tmp_values(current->values);

            tmp_keys.push_back(key);
            tmp_values.push_back(value);

            int index = upper_bound(current->keys.begin(), current->keys.end(), key) - current->keys.begin();
            if(index != tmp_keys.size() - 1){
                for(int i = tmp_keys.size() - 1 ; i > index ; i--){
                    tmp_keys[i] = tmp_keys[i-1];
                    tmp_values[i] = tmp_values[i-1];
                }
                tmp_keys[index] = key;
                tmp_values[index] = value;
            }

            // 生出一個 new leaf
            Node* leaf2 = new Node;
            leaf2->isLeaf = true;

            // 重新連接 pointer：leaf -> new leaf -> original next
            Node* original_next = current->link_to_next_node_for_leaf;
            current->link_to_next_node_for_leaf = leaf2;
            leaf2->link_to_next_node_for_leaf = original_next;

            // 把資料分給兩個 leaf 囉，check + 1
            // 分給原 leaf
            current->keys.resize((num_node_of_leaf)/2 + 1);
            current->values.resize((num_node_of_leaf)/2 + 1);
            for(int i = 0 ; i <= (num_node_of_leaf)/2 ; i++){
                current->keys[i] = tmp_keys[i];
                current->values[i] = tmp_values[i];
            }
            
            // 分給新 leaf
            for(int i = (num_node_of_leaf)/2 + 1 ; i < tmp_keys.size() ; i++){
                leaf2->keys.push_back(tmp_keys[i]);
                leaf2->values.push_back(tmp_values[i]);
            }

            /*
                分完拉然後要把 key 往上提
                1. 原本是 root
                2. 原本是 leaf 所以要提去 internal node
           */
            if(current == root){
                Node* newRoot = new Node;
                newRoot->keys.push_back(leaf2->keys[0]);
                newRoot->ptr_to_children.push_back(current);
                newRoot->ptr_to_children.push_back(leaf2);
                root = newRoot;
            }
            else{
                // insert key to internal
                insert_key_to_Internal(leaf2->keys[0], &parent, &leaf2);
            }
       }
   }

}

void BP_tree::insert_key_to_Internal(int key_insert, Node** current, Node** child)
{
    /*
        situation
        1. internal node is not full -> insert directly
        2. internal node is full -> split
    */
   // situation 1
   if((*current)->keys.size() < num_child_of_internal - 1){
       // find index to insert node
       int index = upper_bound((*current)->keys.begin(), (*current)->keys.end(), key_insert) - (*current)->keys.begin();
       (*current)->keys.push_back(key_insert);

       // put pointer of child into parent
       (*current)->ptr_to_children.push_back(*child);

        if(index != (*current)->keys.size() - 1){
            // 有兩個要排序：pointer to child. key

            // pointer to child
            for(int i = (*current)->ptr_to_children.size() - 1 ; i > (index+1) ; i--){
                (*current)->ptr_to_children[i] = (*current)->ptr_to_children[i-1];
            }

            // key
            for(int i = (*current)->keys.size() - 1 ; i > index ; i--){
                (*current)->keys[i] = (*current)->keys[i-1];
            }

            // 把正確位置的正確值放進去
            (*current)->ptr_to_children[index+1] = *child;
            (*current)->keys[index] = key_insert;
        }
   }
   // situation 2
   else{
        // 作法同 redistribute_leaf
        vector<int> ori_key_node((*current)->keys);
        vector<Node*> ori_pointer_to_children((*current)->ptr_to_children);

        ori_key_node.push_back(key_insert);
        ori_pointer_to_children.push_back(*child);

        int index = upper_bound((*current)->keys.begin(), (*current)->keys.end(), key_insert) - (*current)->keys.begin();
        if(index != ori_key_node.size() - 1){
            for(int i = ori_pointer_to_children.size() - 1 ; i > (index+1) ; i--){
                ori_pointer_to_children[i] = ori_pointer_to_children[i-1];
            }

            for(int i = ori_key_node.size() - 1 ; i > index ; i--){
                ori_key_node[i] = ori_key_node[i-1];
            }

            ori_pointer_to_children[index+1] = *child;
            ori_key_node[index] = key_insert;
        }
        // extract middle key ，所以先取出來，等等都跳過這一格
        int middle_key = ori_key_node[(ori_key_node.size() / 2)];
        int split_index = (ori_key_node.size() / 2);

        // 先生出一個新的 internal node
        Node* newInterNode = new Node;

        // resize
        (*current)->keys.resize(split_index);
        (*current)->ptr_to_children.resize(split_index + 1);

        // 分配囉
        // 分配給原本的 internal node
        for (int i = 0 ; i < split_index ; i++) {
            (*current)->keys[i] = ori_key_node[i];
        }

        for (int i = 0 ; i < split_index + 1; i++) {
            (*current)->ptr_to_children[i] = ori_pointer_to_children[i];
        }

        // 分配給新的 internal node
        // bug!!! 這裡也要 i = split_index + 1
        for(int i = split_index + 1 ; i < ori_key_node.size() ; i++){
            newInterNode->keys.push_back(ori_key_node[i]);
        }

        for(int i = split_index + 1 ; i < ori_pointer_to_children.size() ; i++){
            newInterNode->ptr_to_children.push_back(ori_pointer_to_children[i]);
        }

        // 判斷囉
        if((*current) == root){
            Node* newRoot = new Node;
            newRoot->keys.push_back(middle_key);
            newRoot->ptr_to_children.push_back(*current);
            newRoot->ptr_to_children.push_back(newInterNode);
            root = newRoot;
        }
        else{
            insert_key_to_Internal(middle_key, find_parent(root, *current), &newInterNode);
        }
   }
}

Node* parent = NULL;
Node** BP_tree::find_parent(Node* current, Node* child)
{
    // todo: find parent to insert key to internal node
    // 跑迴圈找 parent 囉
    // 只會判斷 internal node ，所以假如他是 leaf 或者他小孩是 leaf 都不會符合，default
    if(current->isLeaf || current->ptr_to_children[0]->isLeaf){
        return NULL;
    }
    for(int i = 0 ; i < current->ptr_to_children.size() ; i++){
        if(current->ptr_to_children[i] == child){
            parent = current;
        }
        else{
            Node* temp_cur = current->ptr_to_children[i];
            find_parent(temp_cur, child);
        }
    }
    return &parent;
}

void BP_tree::insert_leaf_without_overflow(Node* current, int key, int value)
{
    // 先 push 進去再改位置
    current->keys.push_back(key);
    current->values.push_back(value);

    int index = upper_bound(current->keys.begin(), current->keys.end(), key) - current->keys.begin();

    // 如果不是在 vector 最後一位的話要改位置
    if(index != current->keys.size() - 1){

        // 將 key. value 往後移空出位置放進 index 的地方
        for(int i = current->keys.size() - 1 ; i > index ; i--){
            current->keys[i] = current->keys[i-1];
            current->values[i] = current->values[i-1];
        }

        // 把值放進去相對應的位置囉!
        current->keys[index] = key;
        current->values[index] = value;
    }
}


int BP_tree::search_by_key(int key)
{
    if(root == NULL){
        return -1;
    }
    else{
        Node* cur = root;

        // trace internal nodes and finally move to leaf
        while(cur->isLeaf == false){
            // find children by keys[index]
            // lower_bound：找出vector中「大於或等於」val的「最小值」的位置，[first, last)
            // upper_bound：找出vector中「大於」val的「最小值」的位置
            int index = upper_bound(cur->keys.begin(), cur->keys.end(), key) - cur->keys.begin();

            // move current to position of children
            cur = cur->ptr_to_children[index];
        }

        // in leaf, find the key
        // 嗚嗚嗚這裡是 bug (lower_bound 寫成 upper_bound)
        int index = lower_bound(cur->keys.begin(), cur->keys.end(), key) - cur->keys.begin();

        /* 
            key is not found
            1. keys 裡面沒有 key 值
            2. 所得到的 index 與 keys 大小相同(overflow)
        */
        if(cur->keys[index] != key || index == cur->keys.size()){
            return -1;
        }

        // return value corresponding to key
        return cur->values[index];
    }
}

Node* BP_tree::find_node_in_range(int key)
{
    // 作法同 search_by_key(int key) ，但是要回傳 leaf node，在 range_query 做一整段 leaf node 的比較(用到link_to_next_node_for_leaf)
    if(root == NULL){
        return NULL;
    }
    else{
        Node* cur = root;

        while(cur->isLeaf == false){
            int index = upper_bound(cur->keys.begin(), cur->keys.end(), key) - cur->keys.begin();
            cur = cur->ptr_to_children[index];
        }
        return cur;
    }
}