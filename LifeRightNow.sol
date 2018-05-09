pragma solidity ^0.4.21;


 // _      _  __              
 //| |    (_)/ _|             
 //| |     _| |_ ___          
 //| |    | |  _/ _ \         
 //| |____| | ||  __/         
 //|______|_|_| \___|    _    
 //|  __ \(_)     | |   | |   
 //| |__) |_  __ _| |__ | |_  
 //|  _  /| |/ _` | '_ \| __| 
 //| | \ \| | (_| | | | | |_  
// |_|  \_\_|\__, |_| |_|\__| 
// | \ | |    __/ |           
// |  \| | __|___/    __      
// | . ` |/ _ \ \ /\ / /      
// | |\  | (_) \ V  V /       
// |_| \_|\___/ \_/\_/        

// Dennison Bertram 2018
                            
                            

contract LRN {
    
    //Structure of a Post
    struct Post {
        address creator;
        uint256 time_created;
        string imageUrl;
        string caption;
        uint256 karma;
        uint256 gold;
        uint256 postId;
        uint256 inReplyToPost;
        uint256[] replyPosts;
        
    }
    
    //Array of All Posts
    Post[] public Posts; 
    //Bool Mapping of all Posts
    mapping(uint256 => bool) PostExists;
    
    //Users
    mapping(address => uint) public addressPostCount;
    
    //Contract Balance
    uint256 ContractBalance;
    
    //Users
    
    function makePost(string _imageUrl, string _caption, uint256 _replyID) public payable {
        //Check if ReplyID is valid - 0 means it's a new post. 
        //require(PostExists[_replyID]);
        
        
        uint256 _postId = Posts.length;
        Post memory post;
        
        post.creator = msg.sender;
        post.time_created = now;
        post.imageUrl = _imageUrl;
        post.caption = _caption;
        post.karma = 0;
        post.gold = msg.value;
        post.postId = _postId;
        post.inReplyToPost = _replyID;
        
        ContractBalance = ContractBalance + msg.value;
        
        //Push Post to contract
        Posts.push(post);
        PostExists[_postId];
        
        //Push Reply to Contract
        Posts[_replyID].replyPosts.push(_postId);
        
        //Increment addressPostCount
        addressPostCount[msg.sender] += 1;
        
    }
    
    function replyCount(uint256 _postId) public view returns(uint256){
        return(Posts[_postId].replyPosts.length);
    }
    
    function totalPosts() public view returns(uint256){
        return(Posts.length);
    }
    

    
    
}
