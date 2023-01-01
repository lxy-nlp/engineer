# 数组

## 两数之和

```java
class Solution {
    public int[] twoSum(int[] nums, int target) {
        Map<Integer,Integer> map = new HashMap();
        for(int i = 0; i < nums.length; i++)
        {
            if(map.containsKey(target - nums[i]))
                return new int[]{i,map.get(target-nums[i])};
            map.put(nums[i],i);
        }
        return new int[2];   
    } 
}
```



# 位运算

| 操作符 |                             描述                             | 例子                           |
| :----- | :----------------------------------------------------------: | :----------------------------- |
| ＆     |            如果相对应位都是1，则结果为1，否则为0             | （A＆B），得到12，即0000 1100  |
| \|     |           如果相对应位都是 0，则结果为 0，否则为 1           | （A \| B）得到61，即 0011 1101 |
| ^      |            如果相对应位值相同，则结果为0，否则为1            | （A ^ B）得到49，即 0011 0001  |
| 〜     |     按位取反运算符翻转操作数的每一位，即0变成1，1变成0。     | （〜A）得到-61，即1100 0011    |
| <<     |     按位左移运算符。左操作数按位左移右操作数指定的位数。     | A << 2得到240，即 1111 0000    |
| >>     |     按位右移运算符。左操作数按位右移右操作数指定的位数。     | A >> 2得到15即 1111            |
| >>>    | 按位右移补零操作符。左操作数的值按右操作数指定的位数右移，移动得到的空位以零填充。 | A>>>2得到15即0000 1111         |

因为除法的效率比移位运算要低得多，在实际编程中应尽可能地用移位运算符代替乘除法。

注： >> 和 >>> 在正数上 结果一样 负数上不一样

```java
public class Solution {
    // you need to treat n as an unsigned value
    public int hammingWeight(int n) {
        int count = 0;
        for(int i = 0; i < 32; i++)
        {
            if((n & (1 << i)) != 0)
                count++;
        }
        return count;
    }
}
```



# 递归的灵魂三问

1. 函数是做什么的
2. 参数变量是什么
3. 递归结果的处理

# 动态规划

## 要点

1. 存在重叠子问题
2. 初始状态
3. ！！！递推表达式
4. 一般是最大 最小问题 零钱兑换

## 不同的二叉搜索树

```java
/*
实际上左子树的数量与右子树的数量乘积

*/
class Solution {
    public int numTrees(int n) {
        if(n < 2)
            return n;
        int[] dp  = new int[n+1];
        dp[0] = 1;
        dp[1] = 1;
        for(int i = 2; i < n+1;i++)
        {
            for(int j = 1; j <= i; j++)
            {
                // j是根节点的序号 j-1是左子树个数 i-j是右子树个数
                dp[i] += dp[j-1]*dp[i-j];
            }
        }
        return dp[n];
    }
}
```

## 字串和子序列问题

### 最长公共子串

```java
import java.util.*;

public class LongestSubstring {
    public int findLongest(String A, int n, String B, int m) {
        // write code here
        char[] arr1  = B.toCharArray();
        char[] arr2 = A.toCharArray();
        int[][] dp = new int[m][n];
        int res = 0;
        for(int i = 0; i < n; i++)
        {
            if(arr1[0] == arr2[i])
                dp[0][i] = 1;
        }
        for(int j = 0; j < m; j++)
        {
            if(arr2[0] == arr1[j])
                dp[j][0] = 1;
        }
        for(int i = 1; i < m; i++)
        {
            for(int j = 1; j < n; j++)
            {
                if(arr1[i] == arr2[j])
                {
                    dp[i][j] =dp[i-1][j-1] + 1;
                }
                else
                    dp[i][j] = 0;
                res = Math.max(dp[i][j],res);
            }
        }
        return res;
    }
}
```

### 最长公共子序列

```java
import java.util.*;

public class LCS {
    public int findLCS(String A, int n, String B, int m) {
        // write code here
        char[] arr1 = B.toCharArray();
        char[] arr2 = A.toCharArray();
        int[][] dp = new int[m+1][n+1];
        for(int i = 0; i < m+1;i++)
        {
            Arrays.fill(dp[i],0);
        }
        for(int i = 1; i <= m; i++)
        {
            for(int j = 1;j <= n; j++)
            {
                if(arr1[i-1] == arr2[j-1])
                    dp[i][j] = dp[i-1][j-1] + 1;
                else
                    dp[i][j] = Math.max(dp[i-1][j],dp[i][j-1]);
            }
        }
        return dp[m][n]; 
    }
}
```

注： 最长公共子序列和最长公共子串的区别是公共子序列不是连续的 子串是连续的

### 最长增长子序列

```java
public class Solution
{
        int[] dp = new int[n];
        int res = 1;
        Arrays.fill(dp,1);
        for(int i = 0; i < n; i++)
        {
            for(int j = 0; j < i;j++)
            {
                if(height[i] > height[j])
                    dp[i] = Math.max(dp[j]+1, dp[i]);
                res = Math.max(dp[i],res);
            }
        }
        return res;
    }
}
```

### 最小编辑距离

```java
/*
给你两个单词 word1 和 word2， 请返回将 word1 转换成 word2 所使用的最少操作数  。

你可以对一个单词进行如下三种操作：

插入一个字符
删除一个字符
替换一个字符

输入：word1 = "intention", word2 = "execution"
输出：5
解释：
intention -> inention (删除 't')
inention -> enention (将 'i' 替换为 'e')
enention -> exention (将 'n' 替换为 'x')
exention -> exection (将 'n' 替换为 'c')
exection -> execution (插入 'u')
*/
class Solution {
    public int minDistance(String word1, String word2) {
        int m = word1.length();
        int n = word2.length();
        int[][] dp = new int[m+1][n+1];
        for(int i = 0; i < m+1;i++)
        {
            dp[i][0] = i;
        }
        for(int i = 0; i < n+1;i++)
        {
            dp[0][i] = i;
        }

        for(int i = 1; i < m+1; i++)
        {
            for(int j = 1; j < n+1; j++)
            {
                if(word1.charAt(i-1) == word2.charAt(j-1))
                    dp[i][j] = dp[i-1][j-1];
                else
                    dp[i][j] = Math.min(Math.min(dp[i-1][j],dp[i][j-1]),dp[i-1][j-1]) +1;
            }
        }
        return dp[m][n];
    }
}
```



## 零钱兑换问题（背包问题）

```java
/*
	硬币数量无限
	求所需的硬币最少个数 硬币的排列得到目标金额
*/
class Solution {
    public int coinChange(int[] coins, int amount) {
        int[] dp = new int[amount+1];
        Arrays.fill(dp,amount+1);
        dp[0] = 0;

        for(int i = 1; i <= amount; i++)
        {
            // 金额在外层的原因是 找到每个金额的最小硬币数 
            for(int coin : coins)
            {
                if(coin > i)
                    continue;
                dp[i] = Math.min(dp[i-coin] + 1, dp[i]);
            }
        }
        return dp[amount] > amount ? -1 : dp[amount];
    }
}
```



```java
/*
	硬币无限
	求金额对应的组合数 有多少中组合方式可以得到目标金额
*/
    public static int change(int amount, int[] coins) {
        int[] dp = new int[amount+1];
        Arrays.fill(dp,0);
        dp[0] = 1;
        // 此处coin在外层的原因是 看硬币能否组成目标数
        for( int coin : coins)
        {
            for(int i = 1; i <= amount; i++ )
            {
                if(coin > i)
                    continue;
                dp[i] += dp[i-coin];
            }
        }
        return dp[amount];
    }
```



## 打家劫舍三部曲

注：已经掌握前面两种

```java
/*
不能打劫相邻的房屋
*/
class Solution {

    public int rob(int[] nums) {
        if(nums.length == 0)    return 0;
        int pre = 0, cur = 0, tmp;
        for(int i = 0; i < nums.length; i++)
        {
            tmp = cur;
            cur = Math.max(pre + nums[i],cur);
            pre = tmp;
        }
        return cur;   
    }
}

/*
不能相邻（包括首尾相邻）的房屋 可以看成环形的
*/
class Solution {
    public int rob(int[] nums) {
        if(nums.length == 1)    return nums[0];
        return Math.max(rob(nums,0,nums.length-1),rob(nums,1,nums.length));
    }
    public int rob(int[] nums, int left, int right)
    {
        int pre = 0, cur = 0, tmp;
        for(int i = left; i < right; i++)
        {
            tmp = cur;
            cur = Math.max(pre + nums[i],cur);
            pre = tmp;
        }
        return cur;
    }
}


/*二叉树房屋*/
public int rob(TreeNode root) {
    int[] res = dp(root);
    return Math.max(res[0], res[1]);
}

/* 返回一个大小为 2 的数组 arr
arr[0] 表示不抢 root 的话，得到的最大钱数
arr[1] 表示抢 root 的话，得到的最大钱数 */
public int[] dp(TreeNode root) {
    if (root == null)
        return new int[]{0, 0};
    int[] left = dp(root.left);
    int[] right = dp(root.right);
    // 抢，下家就不能抢了
    int rob = root.val + left[0] + right[0];
    // 不抢，下家可抢可不抢，取决于收益大小
    int not_rob = Math.max(left[0], left[1])
                + Math.max(right[0], right[1]);

    return new int[]{not_rob, rob};
}
```

## 最大子数组问题

```java
// 乘积最大子数组
/*
给你一个整数数组 nums ，请你找出数组中乘积最大的非空连续子数组（该子数组中至少包含一个数字），并返回该子数组所对应的乘积。
测试用例的答案是一个 32-位 整数。子数组 是数组的连续子序列。
*/
// 最小可能会变成最大 最大也有可能变成最小
class Solution {
    public int maxProduct(int[] nums) {
        if(nums == null || nums.length == 0)
            return 0;
        if(nums.length == 1)
            return nums[0];
        int[] MinDp = new int[nums.length];
        int[] MaxDp = new int[nums.length];
        MinDp[0] = nums[0];
        MaxDp[0] = nums[0];
        int max = nums[0];
        for(int i = 1; i < nums.length; i++)
        {
            MaxDp[i] = Math.max(nums[i],Math.max(MinDp[i-1] * nums[i],MaxDp[i-1] * nums[i]));
            MinDp[i] = Math.min(nums[i],Math.min(MinDp[i-1] * nums[i],MaxDp[i-1] * nums[i]));
            max = Math.max(MaxDp[i],max);
        }
        return max;
    }
}
    

/*
输入一个整型数组，数组中的一个或连续多个整数组成一个子数组。求所有子数组的和的最大值。要求时间复杂度为O(n)。
输入: nums = [-2,1,-3,4,-1,2,1,-5,4]
输出: 6
解释: 连续子数组 [4,-1,2,1] 的和最大，为 6。
*/
class Solution {

    public int maxSubArray(int[] nums) {
        int[] dp = new int[nums.length];
        dp[0] = nums[0];
        int max = nums[0];
        for(int i = 1; i < nums.length;i++)
        {
            if(dp[i-1] < 0)
                dp[i] = nums[i];
            else
                dp[i] = dp[i-1]+nums[i];
            max = Math.max(max,dp[i]);
        }
        return max;
    }
}
```

## 爬楼梯问题

### 爬楼梯

```java
class Solution {
    public int climbStairs(int n) {
        int[] dp = new int[n+1];
        if(n < 3)
            return n;
        dp[1] = 1;
        dp[2] = 2;
        for(int i = 3; i <= n; i++)
        {
            dp[i] = dp[i-1] + dp[i-2];
        }
        return dp[n];
    }
}
```

### 解码方法数

```java
class Solution {
        public int numDecodings(String s) {
        int length = s.length();
        int[] dp = new int[length + 1];
        dp[0] = 1;
        for (int i = 1; i <= length; i++) {
            //判断截取一个是否符合（只要不是0，都符合）
            if (s.charAt(i - 1) != '0')
                dp[i] = dp[i - 1];
            //判断截取两个是否符合
            if (i >= 2 && (s.charAt(i - 2) == '1' || s.charAt(i - 2) == '2' && s.charAt(i - 1) <= '6'))
                dp[i] += dp[i - 2];
        }
        return dp[length];
    }
}
```

### 剪绳子

```java
//状态只有剪和不剪
// 不剪就是当前长度 * 剩下长度 剪就是当前长度 * 之前剪过的长度。
class Solution {
    public int integerBreak(int n) {
        int[] dp = new int[n+1];
        dp[1] = 1;
        dp[2] = 1;
        int cur = 0;
        for(int i = 3; i <= n; i++)
        {
            for(int j = 2; j < i; j++)
            {
                cur = Math.max(j * (i-j),dp[i-j] * j);
                dp[i] = Math.max(cur,dp[i]);
            }
        }
        return dp[n];
    }
}
```





# 二叉树

| 树的类型   | 特点和性质                 |
| ---------- | -------------------------- |
| 二叉搜索树 | 中序遍历的结果是非递减序列 |
| 平衡二叉树 | 左右子树的高度差不超过1    |
| 完全二叉树 | 只有右子树可以缺失         |

注：基本框架 前序遍历 中序遍历 后序遍历 以及 层级遍历

## 先序 中序 后序遍历

### 递归



### 迭代

```java
/*
 * public class TreeNode {
 *   int val = 0;
 *   TreeNode left = null;
 *   TreeNode right = null;
 *   public TreeNode(int val) {
 *     this.val = val;
 *   }
 * }
 */
public class Solution {

    // 先序遍历
    public void preorderTraversal (TreeNode root) {
        // write code here
        if(root == null)
            return;
        List<Integer> list = new ArrayList();
        Stack<TreeNode> stack = new Stack();
        stack.push(root);
        while(!stack.isEmpty())
        {
            TreeNode cur = stack.pop();
            list.add(cur.val);
            if(cur.right != null)
                stack.push(cur.right);
            if(cur.left != null)
                stack.push(cur.left);
        }
    }
    // 中序遍历
        public void inorderTraversal (TreeNode root) {
        // write code here
        if(root == null)
            return;

        Stack<TreeNode> stack = new Stack();
        TreeNode cur = root;
        while(!stack.isEmpty() || cur != null)
        {
            while(cur != null)
            {
                stack.push(cur);
                cur = cur.left;
            }
            TreeNode tmp = stack.pop();
            if(tmp.right != null)
                cur = tmp.right;
        }
    }
    
    // 后序遍历
    // 用两个栈 一个用于遍历 一个用于输出
    public int[] postorderTraversal (TreeNode root) {
        // write code here
        if(root == null)
            return new int[0];
        Stack<TreeNode> stack1 = new Stack();
        Stack<TreeNode> stack2 = new Stack();
        stack1.push(root);
        while(!stack1.isEmpty())
        {
            TreeNode cur = stack1.pop();
            stack2.push(cur);
            if(cur.left != null)
                stack1.push(cur.left);
            if(cur.right != null)
                stack1.push(cur.right);
        }
        int[] res = new int[stack2.size()];
        int i = 0;
        while(!stack2.isEmpty())
            res[i++] = stack2.pop().val;
        return res;
    }
}


```





```java
List<Integer> list = new LinkedList();// 结果集
Stack<TreeNode> stack = new Stack(); 
TreeNode cur = root;
while(!stack.isEmpty() || cur != null)
{
    while(cur != null)
    {
        list.add(cur.val);// 前序  后序
        stack.push(cur);
        cur = cur.left; // cur = cur.right; 后序
    }
	TreeNode tmp = stack.pop();
    list.add(cur.val); // 中序
    cur = tmp.right;
}
```



```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public List<Integer> preorderTraversal(TreeNode root) {
        List<Integer> list = new LinkedList();
        if(root == null)
            return list;
        Stack<TreeNode> stack = new Stack();
        stack.push(root);
        while(!stack.isEmpty())
        {
            TreeNode cur = stack.pop();
            list.add(cur.val);
            if(cur.right != null)
                stack.push(cur.right);
            if(cur.left != null)
                stack.push(cur.left);
        }
        return list;
    }
}
```



## 广度优先遍历

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Solution {
    public int[] levelOrder(TreeNode root) {
        if(root == null)
            return new int[0];
        ArrayList<Integer> array = new ArrayList();
        Queue<TreeNode> queue = new LinkedList();
        queue.offer(root);
        while(!queue.isEmpty())
        {
            int size = queue.size();
            for(int i = 0; i < size; i++)
            {
                TreeNode cur = queue.poll();
                array.add(cur.val);
                if(cur.left != null)
                    queue.offer(cur.left);
                if(cur.right != null)
                    queue.offer(cur.right);
            }
        }
        int[] res = new int[array.size()];
        for(int i = 0; i < array.size(); i++)
        {
            res[i] = array.get(i);
        }
        return res;
    }
}
```

## 二叉搜索树

### 判断二叉搜索树

```java
public class BinarySearchTree {
    public static boolean isValidBST(TreeNode root) {
        return helper(root,null,null);
    }
    public static boolean helper(TreeNode root,TreeNode min,TreeNode max)
    {
        if(root == null)    return true;
        if(min != null && root.val <= min.val)
        {
            return false;
        }

        if(max != null && root.val >= max.val)
        {

            return false;
        }
        return helper(root.left,min,root) && helper(root.right,root,max);
    }
}
```

### 恢复搜索二叉树

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    ArrayList<TreeNode> list = new ArrayList();
    public void recoverTree(TreeNode root) {
        inOrder(root);
        TreeNode x = null, y = null;
        for(int i = 0; i < list.size()-1;i++)
        {
            // 针对 321这种情况，如果发现有前一个小于后一个的情况 那么就第一次的前一个记录下来 继续遍历 如果后面有这样的情况，就记录后一个的
            if(list.get(i).val > list.get(i+1).val)
            {
                y = list.get(i+1);
                if(x == null)
                    x = list.get(i);
            }
        }
        if(x != null && y != null)
        {
            int tmp = x.val;
            x.val = y.val;
            y.val = tmp;
        }
    }
    public void inOrder(TreeNode root)
    {
        if(root == null)
            return;
        inOrder(root.left);
        list.add(root);
        inOrder(root.right);
    }
}
```

### 有序数组转二叉树

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public TreeNode sortedArrayToBST(int[] nums) {
        TreeNode root = help(nums,0,nums.length-1);
        return root;
        
    }
    public TreeNode help(int[] nums, int left, int right)
    {
        if(left > right)
            return null;
        int mid = (left + right) / 2;
        TreeNode root = new TreeNode(nums[mid]);
        root.left = help(nums,left,mid - 1);
        root.right = help(nums,mid+1,right);
        return root;
    }
}
```

有序链表转二叉搜索树

```java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode() {}
 *     ListNode(int val) { this.val = val; }
 *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public TreeNode sortedListToBST(ListNode head) {
        return help(head,null);
    }
    public TreeNode help(ListNode left,ListNode right)
    {
        if(left == right)
            return null;
        ListNode mid = searchMid(left,right);
        TreeNode root = new TreeNode(mid.val);
        root.left = help(left,mid);
        root.right = help(mid.next,right);
        return root;
    }
    
    // 寻找链表的中点
    public ListNode searchMid(ListNode left, ListNode right)
    {
        ListNode fast = left;
        ListNode slow = left;
        while(fast != right && fast.next != right)
        {
            fast = fast.next.next;
            slow = slow.next;
        }
        return slow;
    }
}
```





### 不同的二叉搜索树

```java
/*数量*/
class Solution {
    public int numTrees(int n) {
        int[] dp = new int[n+1];
        dp[0] = 1;
        dp[1] = 1;
        for(int i = 2; i <= n; i++)
        {
            for(int j = 0; j < i; j++)
            {
                dp[i] += dp[j] * dp[i-j-1];
            }
        }
        return dp[n];
    }
}

/*具体的树*/
```



### 二叉搜索树中的查找

```java
框架
    // BST中是否存在某值
    public static void BST(TreeNode root,int target)
    {
    	if(root.val == target)
        {
            do sth;
        }
        if(root.val < target)
             BST(root.right,target);
        if(root.val > target)
            BST(root.left,target);
    
    }


/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public TreeNode searchBST(TreeNode root, int val) {
        if(root == null || root.val == val)
            return root;
        TreeNode left = null;
        TreeNode right = null;
        if(root.val > val)
            left = searchBST(root.left,val);
        if(root.val < val)
            right = searchBST(root.right,val);
        return left == null ? right : left;
    }

}

插入
    /**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public TreeNode insertIntoBST(TreeNode root, int val) {
        if(root == null)
            return new TreeNode(val);
        if(root.val == val)
            return root;
        if(root.val > val)
            root.left = insertIntoBST(root.left,val);
        if(root.val < val)
            root.right = insertIntoBST(root.right,val);
        return root;
    }
}
```





## 对称二叉树

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public boolean isSymmetric(TreeNode root) {
        return helper(root.left,root.right);
    }
    public boolean helper(TreeNode left, TreeNode right)
    {
        if(left == null && right == null)
            return true;
        if(left == null || right == null)
            return false;

        if(left.val != right.val)
            return false;
        return helper(left.left,right.right) && helper(left.right,right.left);
    }
}
```



## 序列化二叉树

注： 可以使用前序遍历 后序遍历和层级遍历

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
public class Codec {
    String SEP = ",";
    String NULL = "#";
    // Encodes a tree to a single string.
    public String serialize(TreeNode root) {
        StringBuilder sb = new StringBuilder();
        serialize(root,sb);
        return sb.toString();
    }
    void serialize(TreeNode root,StringBuilder sb)
    {
        if(root == null)
        {
            sb.append(NULL).append(SEP);
            return;
        }
        sb.append(root.val).append(SEP);
        serialize(root.left,sb);
        serialize(root.right,sb);
    }

    // 反序列化 第一步是要找到根节点 然后再找左右子树
    // Decodes your encoded data to tree.
    public TreeNode deserialize(String data) {
        LinkedList<String> nodes = new LinkedList();
        for(String s : data.split(SEP))
            nodes.addLast(s);
        return deserialize(nodes);
    }
    public TreeNode deserialize(LinkedList<String> nodes)
    {
        String first = nodes.removeFirst();
        if(first.equals(NULL))  return null;
        TreeNode root = new TreeNode(Integer.parseInt(first));
        root.left = deserialize(nodes);
        root.right = deserialize(nodes);
        return root;
    }
}

```

## 最近公共祖先

解法：结果会有三种情况

第一 p q其中之一在 以 root为根的子树中	第二 p q都在 以 root为根的子树中 第三 p q都不在

在左子树和右子树中找到p，q 然后再 一层一层的返回

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Solution {
    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
        if(root == null)
            return null;
        if(root == p || root == q)
            return root; 
        TreeNode left = lowestCommonAncestor(root.left,p,q);
        TreeNode right = lowestCommonAncestor(root.right,p,q);
        if(left != null && right != null)
            return root;
        if(left == null && right == null)
            return null;
        return left == null ? right : left;
    }
}
```

## 重构二叉树 自创方法

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */

// 二者的不同之处就在取先序和后序的顺序上 分割和递归的思路是一致的
// 先序遍历和中序遍历重构二叉树
class Solution {
    HashMap<Integer,Integer> map = new HashMap();
    int preRight = 0;
    public TreeNode buildTree(int[] preorder, int[] inorder) {
        int len = preorder.length;
        for(int i = 0;i < len; i++)
        {
            map.put(inorder[i],i);
        }
        return help(preorder,inorder,0,len-1);

    }

    public TreeNode help(int[] preorder,int[] inorder,int inleft,int inright)
    {
        if(inleft > inright)
            return null;
        int split = map.get(preorder[preRight]); // 找到在中序遍历的分割点
        TreeNode root = new TreeNode(preorder[preRight]); // 根节点
        preRight++;
        root.left = help(preorder,inorder,inleft,split-1);
        root.right = help(preorder,inorder,split+1,inright);
        return root;
    }
}

// 后序遍历和中序遍历重构二叉树

class Solution {
    HashMap<Integer,Integer> map = new HashMap();
    int postright;
    public TreeNode buildTree(int[] inorder, int[] postorder) {
        for(int i = 0; i < inorder.length; i++)
        {
            map.put(inorder[i],i);
        }
        postright = inorder.length-1;
        TreeNode root = help(inorder,postorder,0,inorder.length-1);
        return root;
    }

    public TreeNode help(int[] inorder, int[] postorder, int inleft,int inright)
    {
        if(inleft > inright || postright < 0)
            return null;
        TreeNode root = new TreeNode(postorder[postright]);
        int split = map.get(postorder[postright]);
        postright--;
        root.right = help(inorder,postorder,split+1,inright);
        root.left = help(inorder,postorder,inleft,split-1);
        return root;
    }

}
```

## 最大路径和

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    int pathSum = Integer.MIN_VALUE;
    public int maxPathSum(TreeNode root) {
        dfs(root);
        return pathSum;
    }
    public int dfs(TreeNode node)
    {
        if(node == null) 
            return 0;
        int left = dfs(node.left);
        int right = dfs(node.right);
        int ret = Math.max(node.val,node.val + Math.max(left,right));
        pathSum = Math.max(pathSum,Math.max(ret,node.val + left + right));;
        return ret;
    }
}
```



# 单调栈

## 每日温度

```java
class Solution {
    public int[] dailyTemperatures(int[] temperatures) {
        Stack<Integer> stack = new Stack();
        int[] res = new int[temperatures.length];
        for(int i = 0; i < temperatures.length; i++)
        {
            while(!stack.isEmpty() && temperatures[i] > temperatures[stack.peek()])
            {
                int cur = stack.pop();
                res[cur] = i - cur;
            }
            stack.push(i);
        }
        return res;
    }
}
```



## 下一个更大元素 循环版

遍历次数 2 * n - 1   次 类似于循环队列

```java
class Solution {
    public int[] nextGreaterElements(int[] nums) {
        Stack<Integer> stack = new Stack();
        int n = nums.length;
        int[] res = new int[nums.length];
        Arrays.fill(res,-1);
        for(int i = 0; i < 2 *n -1; i++)
        {
            while(!stack.isEmpty() && nums[i % n] > nums[stack.peek()])
            {
                if(nums[i  % n] > nums[stack.peek()])
                {
                    int c = stack.pop();
                    res[c] = nums[i% n];        
                }
            }
            stack.push(i % n);
        }    
        return res;
    }
}
```

# 单调队列

### 滑动窗口最大值

```java
/*

给你一个整数数组 nums，有一个大小为 k 的滑动窗口从数组的最左侧移动到数组的最右侧。你只可以看到在滑动窗口内的 k 个数字。滑动窗口每次只向右移动一位。
返回 滑动窗口中的最大值 。
输入：nums = [1,3,-1,-3,5,3,6,7], k = 3
输出：[3,3,5,5,6,7]
解释：
滑动窗口的位置                最大值
---------------               -----
[1  3  -1] -3  5  3  6  7       3
 1 [3  -1  -3] 5  3  6  7       3
 1  3 [-1  -3  5] 3  6  7       5
 1  3  -1 [-3  5  3] 6  7       5
 1  3  -1  -3 [5  3  6] 7       6
 1  3  -1  -3  5 [3  6  7]      7

*/
class Solution {
    public int[] maxSlidingWindow(int[] nums, int k) {
        int[] res = new int[nums.length - k +1];
        LinkedList<Integer> queue = new LinkedList();
        
        for(int right = 0; right < nums.length; right++)
        {
            while(!queue.isEmpty() && nums[right] >= nums[queue.peekLast()])
                queue.removeLast();
            queue.addLast(right);
            int left = right - k + 1;
            if(queue.peekFirst() < left)
                queue.removeFirst();
            if(right+1 >= k)
                res[left] = nums[queue.peekFirst()];
        }
        return res;
    }
}
```

### 队列中的最大值 要求时间复杂度是O(1)

```java
class MaxQueue {

    Queue<Integer> queue;
    Deque<Integer> mqueue;    
    public MaxQueue() {
        queue = new LinkedList();
        mqueue = new LinkedList();

    }
    
    public int max_value() {
        if(mqueue.isEmpty())
            return -1;
        return mqueue.peekFirst();
        
    }
    
    public void push_back(int value) {
        while(!mqueue.isEmpty() && mqueue.peekLast() < value)
            mqueue.pollLast();
        mqueue.offerLast(value);
        queue.offer(value);
        
    }
    
    public int pop_front() {
        if(queue.isEmpty())
            return -1;
        int cur = queue.poll();
        if(cur == mqueue.peekFirst())
            mqueue.pollFirst();
        return cur;    
    }
}
```



# 寻找缺失的数

```java
// 给出一个包含 0 .. N 中 N 个数的序列，找出0 .. N 中没有出现在序列中的那个数。
public class Solution {
    /**
     * @param nums: An array of integers
     * @return: An integer
     */
    public int findMissing(int[] nums) {
        // write your code here
        int len = nums.length;
        for(int i = 0; i < len; i++)
        {
            while(nums[i] < len && nums[nums[i]] != nums[i])
            {
                swap(nums,nums[i],i);
            }
        }
        for(int i = 0; i < len; i++)
        {
            if(nums[i] != i)
                return i;
        }
        return len;
    }
    public void swap(int[] nums, int i, int j)
    {
        int tmp = nums[i];
        nums[i] = nums[j];
        nums[j] = tmp;
    }
}

// 还可以用等差数列的思想做
public class Solution {
    /**
     * @param nums: An array of integers
     * @return: An integer
     */
    public int findMissing(int[] nums) {
        // write your code here
        int N = nums.length;
        long sum = (N+1)*N / 2;
        for(int i = 0; i < N; i++)
        {
            sum -= nums[i];
        }
        return (int)sum;
    }
}


// 寻找缺失的第一个正数


```







# 缓存淘汰算法

## LRU Least Recently Used

数据结构包含 双向链表 和 哈希表

头部是最近使用的 尾部是最久远使用的

！！！思路： 用双向链表记录顺序 	哈希表辅助定位



```java
class LRUCache {
    //双向链表
    class Node
    {
        int key;
        int val;
        Node prev,next;
        public Node(){};
        public Node(int key, int val)
        {
            this.key = key;
            this.val = val;
        }
    }
    private Map<Integer,Node> cache = new HashMap<Integer,Node>(); 
    private int size;
    private int capacity;
    private Node head,tail; // 双向链表的首尾节点

    public LRUCache(int capacity) {
        this.size = 0;
        this.capacity = capacity;
        head = new Node();
        tail = new Node();
        head.next = tail;
        tail.prev = head;
    }

    
    public int get(int key) {
        Node node = cache.get(key);
        if(node == null)
            return -1;
        moveToHead(node);
        return node.val;
    }
    
    public void put(int key, int value) {
        Node node = cache.get(key);
        if(node == null)
        {
            Node newNode = new Node(key,value);
            cache.put(key,newNode);
            addToHead(newNode);
            ++size;
            if(size > capacity)
            {
                Node tail = removeTail();
                cache.remove(tail.key);
                --size;
            }
        }
        else
        {
            // 更新 并 放到 头部
            node.val = value;
            moveToHead(node);
        }
    }
    // 直接加到头结点
    public void addToHead(Node node)
    {
        node.prev = head;
        node.next = head.next;
        head.next.prev = node;
        head.next = node;
    }
    // 把某个节点 放到 头结点
    public void moveToHead(Node node)
    {
        // 先删 再放
        remove(node); 
        addToHead(node);
    }
    // 尾部删除
    public Node removeTail()
    {
        Node res = tail.prev;
        remove(res);
        return res;
    }
    //删除一个节点
    public void remove(Node node)
    {
        node.prev.next = node.next;
        node.next.prev = node.prev;
    }
}
```

## LFU Least Frequently Used



# 回溯算法

## 总结

回溯算法主要用于解决 排列 组合问题。

排列问题 不包含自身那个数字 所以需要避开 

组合 与顺序无关 所以要去重 回溯函数里 要从下一个数字开始

另外 若 选择里有重复的数字 那么需要去重 跳过

框架：

```java
public void backward(int[] choices)
{
    if(条件)
    {
        do;
        return;
    }
    for(选择:选择集)
    {
        if(条件)
            break;/continue; //剪枝
        做选择;
        backward();
        撤销选择；
    }
}
```

子集

```java
// 数组中不包含重复数字
class Solution {
    public List<List<Integer>> subsets(int[] nums) {
            List<List<Integer>> res = new LinkedList();
            LinkedList<Integer> track = new LinkedList();
            Arrays.sort(nums);
            trackback(nums,0,track,res);
            res.add(new LinkedList());
            return res;
    }
    public void trackback(int[] nums, int start, LinkedList<Integer> track, List<List<Integer>> res)
    {
        if(start > nums.length-1)
        {
            return;
        }
        for(int i = start; i < nums.length; i++)
        {
            track.add(nums[i]);
            res.add(new LinkedList(track));
            trackback(nums,i+1,track,res);
            track.removeLast();
        }
    }
}
// 数组中包含重复数字 需要去重
class Solution {
    List<List<Integer>> res = new LinkedList();
    LinkedList<Integer> list = new LinkedList();
    public List<List<Integer>> subsetsWithDup(int[] nums) {
        res.add(new LinkedList());
        Arrays.sort(nums);
        help(nums,0);
        return res;
    }
    public void help(int[] nums, int index)
    {
        if(index > nums.length - 1)
            return;
        for(int i = index;i < nums.length; i++)
        {
            if(i > index && nums[i] == nums[i-1]) // 去重操作
                continue; 
            list.add(nums[i]);
            res.add(new LinkedList(list));
            help(nums,i+1);
            list.removeLast();
        }
    }
}
```









## 括号生成

```java
class Solution {
    List<String> res = new LinkedList();
    public List<String> generateParenthesis(int n) {
        helper(n,n,"");
        return res;
    }
    public void helper(int left,int right, String s)
    {
        if(left == 0 && right == 0)
        {
            res.add(s);
            return;
        }
        if(left > 0)
            helper(left-1,right,s+"(");
        if(left < right && right > 0)
            helper(left,right-1,s+")");  
    }
}
```



## 组合总和

```java
// 可重复
class Solution {
    List<List<Integer>> res = new LinkedList();
    LinkedList<Integer> list = new LinkedList();
    boolean[] flag;
    public List<List<Integer>> combinationSum(int[] candidates, int target) {
        Arrays.sort(candidates);
        flag = new boolean[candidates.length];
        helper(0,candidates,0,target);
        return res;
    }
    public void helper(int start, int[] candidates, int sum, int target)
    {
        if(sum >= target)
        {
            if(sum == target)
            {
                LinkedList<Integer> sl = new LinkedList(list);
                if(!res.contains(sl))
                    res.add(sl);
            }
            return;
        }
        for(int i = start; i < candidates.length; i++)
        {
            if(candidates[i] > target)
            {
                break;
            }
            sum += candidates[i];
            list.add(candidates[i]);
            helper(i,candidates,sum,target);
            sum -= list.removeLast();
        }
    }
}

// 不可重复

class Solution {
    List<List<Integer>> res = new LinkedList();
    LinkedList<Integer> list = new LinkedList();
    boolean[] flag;
    public List<List<Integer>> combinationSum2(int[] candidates, int target) {
        flag = new boolean[candidates.length];
        Arrays.sort(candidates);
        helper(candidates,target,0);
        return res;
    }
    public void helper(int[] candidates, int target, int start)
    {
        if(target == 0)
        {
            res.add(new LinkedList(list));
            return;
        }
        for(int i = start; i < candidates.length; i++)
        {
            if(candidates[i] > target)
                break; 
            if(i > start && candidates[i] == candidates[i-1]) // 去重操作
                continue;
            list.add(candidates[i]);
            helper(candidates,target - candidates[i],i+1);
            list.removeLast();
        }
    }
}

// 找出所有相加之和为 n 的 k 个数的组合。组合中只允许含有 1 - 9 的正整数，并且每种组合中不存在重复的数字。
class Solution {
    List<List<Integer>> res = new LinkedList();
    LinkedList<Integer> list = new LinkedList();
    int sk;
    public List<List<Integer>> combinationSum3(int k, int n) {
        sk = k;
        helper(n,1);
        return res;
    }
    public void helper(int target,int start)
    {
        if(list.size() == sk && target == 0)
        {
            res.add(new LinkedList(list));
            return;
        }
        for(int i = start; i <= 9; i++)
        {
            if(i > target)
                break;
            list.add(i);
            helper(target-i,i+1);
            list.removeLast();
        }
    }
}

```



## 全排列

```java
class Solution {
    List<List<Integer>> res = new LinkedList();
    LinkedList<Integer> list = new LinkedList();
    boolean[] flag;
    public List<List<Integer>> permute(int[] nums) {
        flag  = new boolean[nums.length];
        help(nums);
        return res;
    }
    public void help(int[] nums)
    {
        if(list.size() == nums.length)
        {
            res.add(new LinkedList(list));
            return;
        }
        for(int i = 0; i < nums.length; i++)
        {
            if(flag[i])
                continue;
            flag[i] = true;
            list.add(nums[i]);
            help(nums);
            list.removeLast();
            flag[i] = false;
        }
    }

}
```

## 组合

```java
class Solution {
    List<List<Integer>> res = new LinkedList();
    LinkedList<Integer> list =  new LinkedList();
    int sk;
    public List<List<Integer>> combine(int n, int k) {
        sk = k;
        helper(n,1);
        return res;
    }
    public void helper(int n, int start)
    {
        if(list.size() == sk)
        {
            res.add(new LinkedList(list));
            return;
        }
        for(int i = start; i <= n; i++)
        {
            list.add(i);
            helper(n,i+1);
            list.removeLast();
        }
    }
}

```

## 子集

```java
/*
给你一个整数数组 nums ，数组中的元素 互不相同 。返回该数组所有可能的子集（幂集）。
解集 不能 包含重复的子集。你可以按 任意顺序 返回解集。
输入：nums = [1,2,3]
输出：[[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]
*/
class Solution {
    List<List<Integer>> res = new LinkedList();
    LinkedList<Integer> list = new LinkedList();
    public List<List<Integer>> subsets(int[] nums) {
        res.add(new LinkedList());
        helper(nums,0);
        return res;

    }

    public void helper(int[] nums, int cur)
    {
        if(cur > nums.length - 1)
        {
            return;
        }
        for(int i = cur; i < nums.length; i++)
        {
            list.add(nums[i]);
            res.add(new LinkedList(list));
            helper(nums,i+1);
            list.removeLast();
        }

    }
}

/*
    给你一个整数数组 nums ，其中可能包含重复元素，请你返回该数组所有可能的子集（幂集）。
    解集 不能 包含重复的子集。返回的解集中，子集可以按 任意顺序 排列。
    输入：nums = [1,2,2]
    输出：[[],[1],[1,2],[1,2,2],[2],[2,2]]
*/
class Solution {
    List<List<Integer>> res = new LinkedList();
    LinkedList<Integer> list = new LinkedList();
    public List<List<Integer>> subsetsWithDup(int[] nums) {
        Arrays.sort(nums);
        res.add(new LinkedList());
        helper(nums,0);
        return res;
    }
    public void helper(int[] nums,int cur)
    {
        if(cur > nums.length - 1)
            return;
        for(int i = cur; i < nums.length; i++)
        {
            if(i > cur && nums[i] == nums[i-1])
                continue;
            list.add(nums[i]);
            res.add(new LinkedList(list));
            helper(nums,i+1);
            list.removeLast();
        }
    }
}
```

## 有效的IP地址

```java
/*
有效 IP 地址 正好由四个整数（每个整数位于 0 到 255 之间组成，且不能含有前导 0），整数之间用 '.' 分隔。

例如："0.1.2.201" 和 "192.168.1.1" 是 有效 IP 地址，但是 "0.011.255.245"、"192.168.1.312" 和 "192.168@1.1" 是 无效 IP 地址。
给定一个只包含数字的字符串 s ，用以表示一个 IP 地址，返回所有可能的有效 IP 地址，这些地址可以通过在 s 中插入 '.' 来形成。你 不能 重新排序或删除 s 中的任何数字。你可以按 任何 顺序返回答案。

*/
class Solution {
    List<String> res= new LinkedList();
    int len;
    public List<String> restoreIpAddresses(String s) {
        // if(!isValid(s))
        //     return res;
        len = s.length() + 3;
        helper(s,"");
        return res;
    }
    public void helper(String s, String target)
    {
        if(s.length() == 0 && target.length() == len+1)
        {
            res.add(target.substring(0,len));
            return;
        }
        for(int i = 0; i < 3; i++)
        {
            if(s.length() < i+1 || !isValid2(s.substring(0,i+1)))
                continue;
            helper(s.substring(i+1),target+s.substring(0,i+1)+".");           
        }
    }
    public boolean isValid(String s)
    {
        for(int i = 0; i < s.length();i++)
        {
            if(s.charAt(i) - '0' < 0 || s.charAt(i) - '0' > 9)
                return false;
        }
        return true;
    }
    public boolean isValid2(String s)
    {
        if(Integer.valueOf(s) > 255 || (s.length() > 1 && s.charAt(0) == '0'))
            return false;
        return true;
    }
}
```

# 排序

## 快速排序

## 归并排序

## 集合和数组的排序

```java
1. Arrays.sort(nums,new Comparator<>()
            {
                public int compare(Integer o1,Integer o1)
                {
                    return o2.compareTo(o1); // 降序排列
                }
            });
Arrays可以换成 Collections;

2. class Person implements Comparable<Person>
{
    public int compareTo(Person o)
    {
        if(this.age > o.age)
            return 1;
        else if(this.age < o.age)
            return -1;
      	else
            return 0;
            
    }
}

  


```





# 数学

## 除自身之外的乘积

```java
/*给你一个整数数组 nums，返回 数组 answer ，其中 answer[i] 等于 nums 中除 nums[i] 之外其余各元素的乘积 。
题目数据 保证 数组 nums之中任意元素的全部前缀元素和后缀的乘积都在  32 位 整数范围内。
请不要使用除法，且在 O(n) 时间复杂度内完成此题。
*/

class Solution {
    public int[] productExceptSelf(int[] nums) {
        int[] res = new int[nums.length];
        res[0] = 1;
        for(int i = 1; i < nums.length; i++)
        {
            res[i] = res[i-1] * nums[i-1];
        }
        int r = 1;
        for(int i = nums.length - 1; i >= 0; i--)
        {
            res[i] *= r;
            r *= nums[i];
        }
        return res;
    }
}
```



# 出现一次的数字

```java
// 数组中有两个出现一次的数字
class Solution {
    int[] res = new int[2];
    public int[] singleNumbers(int[] nums) {
        // 求异或
        int ret = 0, a = 0, b = 0, div = 1;
        for(int n : nums)
        {
            ret ^= n;
        }
        // 定位置
        while((div & ret) == 0)
            div <<= 1;
        // 分组找
        for(int n : nums)
        {
            if((div & n) == 0)
                a ^= n;
            else
                b ^= n;
        }
        return new int[]{a,b};
    }
}


// 数组中有一个出现一次的数字
```

下一个数字

```java
class Solution {
    public void nextPermutation(int[] nums) {
        
        int n = nums.length;
        int split = -1;
        for(int i = n-1; i > 0; i--)
        {
            if(nums[i] > nums[i-1])
            {
                split = i-1;
                break;
            }
        }
        if(split == -1)
        {
            reverse(nums,0,n-1);
        }
        else
        {
            for(int i = n-1;i > split;i--)
            {
                if(nums[i] > nums[split])
                {
                    swap(nums,i,split);
                    reverse(nums,split+1,n-1);
                    break;
                }
            }
        }

    }
    public void swap(int[] nums, int i, int j)
    {
        int tmp = nums[i];
        nums[i] = nums[j];
        nums[j] = tmp;
    }

    public void reverse(int[] nums, int left, int right)
    {
        while(left < right)
        {
            swap(nums,left,right);
            left++;
            right--;
        }
    }
}
```



# 二分查找



## 排序数组中查找该数字出现的次数

```java
class Solution {
    public int search(int[] nums, int target) {
        int left = binarySearch(nums,target,true);
        int right = binarySearch(nums,target,false)-1;
        if(left <= right && nums[left] == target && nums[right] == target)
            return right - left + 1;
        return 0;
    }
    public int binarySearch(int[] nums, int target, boolean lower)
    {
        int left = 0, right = nums.length - 1, ans = nums.length;
        while(left <= right)
        {
            int mid = left + (right - left) / 2; // 防止溢出
            if(nums[mid] > target || (lower && nums[mid] >= target))
            {
                right = mid-1;
                ans = mid;
            }
            else
                left = mid+1;
        }
        return ans;
    }
}
```



# 整数

```java
// 整数反转
class Solution {
    public int reverse(int x) {
        int flag = 1;
        if(x < 0)
        {
            flag = -1;
            x *= -1;
        }
        int sum = 0;
        while(x > 0)
        {
            if(sum < -214748364 || sum > 214748364 )
                return 0;
            int k = x % 10;
            sum = sum * 10 + k;
            x /= 10;
        }
        return sum * flag;
    }
}
```

# 双指针

## 盛水最多的容器

```java
class Solution {
    public int maxArea(int[] height) {
        int left = 0, right = height.length - 1;
        int maxArea = 0;
        while(left < right)
        {
            if(height[left] > height[right])
            {
                maxArea = Math.max(maxArea,(right-left) * height[right]);
                right--;
            }
            else
            {
                maxArea = Math.max(maxArea,(right-left) * height[left]);
                left++;
            }
        }
        return maxArea;
    }
}
```

# 栈

## 合并区间与插入区间

```java
// 合并区间 和 插入区间
class Solution {
    public int[][] merge(int[][] intervals) {
        Stack<Integer> stack = new Stack();
        Arrays.sort(intervals, new Comparator<int[]>() {
	    public int compare(int[] o1, int[] o2) {
		    if (o1[0] == o2[0])
			    return o1[1] - o2[1];
		    return o1[0] - o2[0];
	}
});

        stack.push(intervals[0][0]);
        stack.push(intervals[0][1]);
        for(int i = 1; i < intervals.length;i++)
        {
            if(intervals[i][0] <= stack.peek())
            {
                if(intervals[i][1] > stack.peek())
                {
                    stack.pop();
                    stack.push(intervals[i][1]);
                }
            }
            else
            {
                stack.push(intervals[i][0]);
                stack.push(intervals[i][1]);
            }
        }
        int count = stack.size() / 2;
        int[][] res = new int[count][2];
        for(int i = count - 1; i >=0; i--)
        {
            int[] tmp = new int[2];
            tmp[1] = stack.pop();
            tmp[0] = stack.pop();
            res[i] = tmp;
        }
        return res;
    }
}


// 插入区间
class Solution {
    public int[][] insert(int[][] intervals, int[] newInterval) {
        Stack<Integer> stack = new Stack();
        int split = -1;
        int n = intervals.length;
        int[][] newArr = new int[n+1][2];
        for(int i = 0; i < n;i++)
        {
            newArr[i] = intervals[i];
        }
        newArr[n] = newInterval;
        Arrays.sort(newArr,new Comparator<>(){
            public int compare(int[] o1,int[] o2)
            {
                if(o1[0] == o2[0])
                    return o2[1] - o1[1];
                else
                    return o1[0] - o2[0];
            }
        });
        stack.push(newArr[0][0]);
        stack.push(newArr[0][1]);
        for(int i = 1; i < newArr.length;i++)
        {
            if(newArr[i][0] <= stack.peek())
            {
                if(newArr[i][1] > stack.peek())
                {
                    stack.pop();
                    stack.push(newArr[i][1]);
                }
            }
            else
            {
                stack.push(newArr[i][0]);
                stack.push(newArr[i][1]);
            }
        }
        int len = stack.size() / 2;
        int[][] res = new int[len][2];
        for(int i = len-1; i >= 0; i--)
        {
            res[i][1] = stack.pop();
            res[i][0] = stack.pop();
        }
        return res;
    }
}
```

## 最小栈

```java
class MinStack {
    Stack<Integer> stack = new Stack();
    Stack<Integer> aux = new Stack();
    int minVal = Integer.MAX_VALUE;
    public MinStack() {
        aux.push(minVal);
    }
    
    public void push(int val) {
        stack.push(val);
        aux.push(Math.min(aux.peek(),val));

    }
    
    public void pop() {
        stack.pop();
        aux.pop();
    }
    
    public int top() {
        return stack.peek();
    }
    
    public int getMin() {
        return aux.peek();
    }
}
```

## 最长有效括号

```java
class Solution {
    public int longestValidParentheses(String s) {
        char[] arr = s.toCharArray();
        Stack<Integer> stack = new Stack();
        stack.push(-1);
        int res = 0;
        for(int i = 0; i < arr.length; i++)
        {
            if(arr[i] == '(')
                stack.push(i);
            else
            {
                stack.pop();
                if(stack.isEmpty())
                    stack.push(i);
                else
                    res = Math.max(res,i-stack.peek());
            }
        }
        return res;
    }
}
```



# 链表

```java
// 移除链表中的元素 
class Solution {
    public ListNode removeElements(ListNode head, int val) {
        while(head != null && head.val == val)
            head = head.next;
        if(head == null)
            return null;
        ListNode cur = head, tmp = head.next;
        while(tmp != null)
        {
            if(tmp.val == val)
            {
                cur.next = tmp.next;
            }
            else
            {
                cur = cur.next;
            }
             tmp = cur.next;
        }
        return head;
    }
}
```



# 滑动窗口问题

## 和最小的数组长度

```java
/*
给定一个含有 n 个正整数的数组和一个正整数 target 。

找出该数组中满足其和 ≥ target 的长度最小的 连续子数组 [numsl, numsl+1, ..., numsr-1, numsr] ，并返回其长度。如果不存在符合条件的子数组，返回 0 。
*/

class Solution {
    public int minSubArrayLen(int target, int[] nums) {
        int cur = 0;
        for(int n : nums)
        {
            cur += n;
        }
        if(cur < target)
            return 0;
        cur = 0;
        int len = nums.length;
        int left = 0, right = 0;
        while(right <= nums.length && left <= right)
        {
            while(cur >= target)
            {
                len = Math.min(len,right-left);
                cur -= nums[left];
                left++;
            }
            if(right > nums.length -1)
                break;
            cur += nums[right];
            right++;
        }
        return len;
    }
}
```

## 覆盖子串问题

```java
// s2中是否包含s1的排列
class Solution {
    public boolean checkInclusion(String s1, String s2) {
        int m = s1.length();
        HashMap<Integer,Integer> need = new HashMap(); 
        for(int i = 0; i < m; i++) // 记录s1中字符的数量
        {
            int c = s1.charAt(i)-97;
            need.put(c,need.getOrDefault(c,0)+1);
        }
        int left = 0, right = 0;
        int n = s2.length();
        int[] window = new int[26];
        int valid = 0;
        while(right < n) // 遍历s2串
        {
            int c = s2.charAt(right) - 97;
            right++;
            if(need.containsKey(c))
            {
                window[c]++;
                if(window[c] == need.get(c))
                    valid++;
            }
            // 每次都会在这个范围内检查是否符合要求
            while(right - left >= m)
            {
                if(valid == need.size())
                {
                    return true;
                }
                int d = s2.charAt(left) -97;
                left++;
                if(need.containsKey(d))
                {
                    if(window[d] == need.get(d))
                        valid--;
                    window[d]--;
                }
            }
        }
        return false;
    }
}


// s2中包含s1的最小长度
```

# N数之和

## 两数之和

```java
class Solution {
    public int[] twoSum(int[] nums, int target) {
        HashMap<Integer,Integer> map = new HashMap();
        for(int i = 0; i < nums.length; i++)
        {
            if(map.get(target - nums[i]) != null)
                return new int[]{map.get(target-nums[i]),i};
            map.put(nums[i],i);
        }
        return new int[2];
    }
}
```

## 三数之和

```java
import java.util.*;
public class Solution {
    public ArrayList<ArrayList<Integer>> threeSum(int[] nums) {
        ArrayList<ArrayList<Integer>> list = new ArrayList();
        Arrays.sort(nums);
        for(int i = 0; i < nums.length - 2; i++)
        {
            // 当 i = 0 时，其实后面所有的以 -1作为第一个数字的情况都包含了，所以 如果后面的数如果和这个数相同就跳过
            if(i > 0 && nums[i] == nums[i-1])    continue;   // -1,-1,-1,0,1,1,2
            int left = i+1, right = nums.length - 1;
            while(left < right)
            {
                int sum = nums[i] + nums[left] + nums[right];
                if(sum == 0)
                {
                    ArrayList<Integer> tmp = new ArrayList<Integer>(Arrays.asList(nums[i],nums[left],nums[right]));
                    list.add(tmp);
                    while(left < right && nums[left] == nums[left+1]) left++; 如果数字相同 就向前推进 直到相同的最后一个数字
                    while(left < right && nums[right] == nums[right - 1]) right--;
                    left++; 下一个数字就是新数字了
                    right--;
                    if(left >= right)
                        break;
                }
                else if(sum < 0) left++;
                else    right--;
            }
        }
        return list;
    }
}
```

## 四数之和

```java
class Solution {
    public List<List<Integer>> fourSum(int[] nums, int target) {
        List<List<Integer>> quadruplets = new ArrayList<List<Integer>>();
        if (nums == null || nums.length < 4) {
            return quadruplets;
        }
        Arrays.sort(nums);
        int length = nums.length;
        for (int i = 0; i < length - 3; i++) {
            if (i > 0 && nums[i] == nums[i - 1]) {
                continue;
            }
            if ((long) nums[i] + nums[i + 1] + nums[i + 2] + nums[i + 3] > target) { // 如果当前最小已经大于target 剪枝
                break;
            }
            if ((long) nums[i] + nums[length - 3] + nums[length - 2] + nums[length - 1] < target) { // 如果当前最大小于target 剪枝
                continue;
            }
            for (int j = i + 1; j < length - 2; j++) {
                if (j > i + 1 && nums[j] == nums[j - 1]) {
                    continue;
                }
                if ((long) nums[i] + nums[j] + nums[j + 1] + nums[j + 2] > target) {
                    break;
                }
                if ((long) nums[i] + nums[j] + nums[length - 2] + nums[length - 1] < target) {
                    continue;
                }
                int left = j + 1, right = length - 1;
                while (left < right) {
                    int sum = nums[i] + nums[j] + nums[left] + nums[right];
                    if (sum == target) {
                        quadruplets.add(Arrays.asList(nums[i], nums[j], nums[left], nums[right]));
                        while (left < right && nums[left] == nums[left + 1]) {
                            left++;
                        }
                        left++;
                        while (left < right && nums[right] == nums[right - 1]) {
                            right--;
                        }
                        right--;
                    } else if (sum < target) {
                        left++;
                    } else {
                        right--;
                    }
                }
            }
        }
        return quadruplets;
    }
}
```

