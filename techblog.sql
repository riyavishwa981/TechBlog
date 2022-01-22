-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 22, 2022 at 05:27 PM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `techblog`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `cid` int(12) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`cid`, `name`, `description`) VALUES
(1, 'Java Programming', 'Java is a high-level, class-based, object-oriented programming language that is designed to have as few implementation dependencies as possible. It is a general-purpose programming language intended to let programmers write once, run anywhere (WORA),'),
(2, 'Python Programming', 'Python is an interpreted high-level general-purpose programming language. Its design philosophy emphasizes code readability with its use of significant indentation. Its language constructs as well as its object-oriented approach aim to help programme'),
(3, 'Data Structures', 'Data Structure can be defined as the group of data elements which provides an efficient way of storing and organizing data in the computer so that it can be used efficiently. Some examples of Data Structures are arrays, Linked List, Stack, Queue, etc'),
(5, 'Algorithm', 'Algorithm is a step-by-step procedure, which defines a set of instructions to be executed in a certain order to get the desired output. Algorithms are generally created independent of underlying languages, i.e. an algorithm can be implemented in more'),
(6, 'Artificial Intelligence', 'Artificial intelligence is a theory and development of computer systems that can perform tasks that normally require human intelligence. Speech recognition, decision-making, visual perception, for example, are features of human intelligence that arti');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `cid` int(12) NOT NULL,
  `commentcon` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `pid` int(12) NOT NULL,
  `uid` int(12) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`cid`, `commentcon`, `pid`, `uid`, `date`) VALUES
(1, '😜😀😊😃', 13, 34, '2021-12-22 08:53:18'),
(2, 'sdnd', 25, 34, '2021-12-24 09:31:03'),
(3, 'aakhir kaar ho gaya comment', 25, 34, '2021-12-24 09:31:24'),
(4, 'hjksadjk', 25, 34, '2021-12-24 09:33:37'),
(5, 'very nice post', 22, 34, '2021-12-24 09:44:45'),
(6, 'ekdum mast', 25, 38, '2021-12-24 09:45:32'),
(7, 'nice', 25, 35, '2021-12-24 10:05:28'),
(9, 'Awesome content', 13, 34, '2021-12-28 05:39:58'),
(10, 'mast h bhai ', 13, 38, '2021-12-28 06:45:40'),
(13, 'la la al lalalalal', 24, 35, '2021-12-28 09:18:43'),
(18, '😜😀😊😃', 13, 35, '2021-12-28 09:28:23'),
(22, 'bajbajwbdjawbdkajwhd', 13, 35, '2021-12-29 08:18:36'),
(23, 'hhhkadkwjfakw', 13, 34, '2021-12-29 13:56:13'),
(26, 'ejrhjwehjew', 18, 34, '2021-12-31 09:00:02'),
(27, 'hdwahawhiwr riyaaaa jhfjsbfjze gughg', 24, 36, '2021-12-31 09:24:37'),
(29, 'hdwahawhiwr riyaaaa jhfjsbfjze gughg', 24, 36, '2021-12-31 09:28:24'),
(30, 'ghgjhdkehdk', 18, 35, '2021-12-31 09:47:06'),
(31, 'hi iiiiiii', 18, 35, '2021-12-31 09:47:14'),
(34, 'vhvhnvjhvjh', 18, 34, '2021-12-31 10:35:10'),
(36, ',sd,s,df,sdf', 25, 41, '2022-01-02 09:22:18'),
(37, 'very nice content by you', 25, 41, '2022-01-22 16:19:20');

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `lid` int(20) NOT NULL,
  `pid` int(20) NOT NULL,
  `uid` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`lid`, `pid`, `uid`) VALUES
(91, 9, 34),
(97, 13, 34),
(101, 10, 34),
(104, 10, 35),
(105, 13, 35),
(108, 10, 36),
(113, 18, 34),
(114, 22, 35),
(115, 23, 35),
(116, 24, 35),
(117, 24, 36),
(118, 23, 36),
(119, 25, 36),
(121, 22, 38),
(122, 24, 38),
(123, 23, 38),
(124, 18, 38),
(125, 13, 38),
(126, 10, 38),
(127, 9, 35),
(129, 13, 36),
(130, 25, 34),
(131, 24, 34),
(132, 22, 34),
(133, 23, 34),
(134, 25, 38),
(135, 25, 35),
(136, 24, 41),
(138, 22, 41),
(139, 23, 41),
(140, 13, 41),
(141, 9, 41),
(142, 10, 41),
(143, 18, 41),
(144, 25, 41);

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `pid` int(12) NOT NULL,
  `pTitle` varchar(160) NOT NULL,
  `pContent` longtext DEFAULT NULL,
  `pCode` longtext DEFAULT NULL,
  `pPic` varchar(100) DEFAULT NULL,
  `pDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `catId` int(12) NOT NULL,
  `userId` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`pid`, `pTitle`, `pContent`, `pCode`, `pPic`, `pDate`, `catId`, `userId`) VALUES
(9, 'Why python is easy?', 'becoz python i a very very very very good good good good languaz. mind ur lenguaz im not your yrr', NULL, 'python.jpg', '2021-12-08 11:09:12', 2, 35),
(10, 'Why java is so popular?', 'One of the biggest reasons why Java is so popular is the platform independence. Programs can run on several different types of computer; as long as the computer has a Java Runtime Environment (JRE) installed, a Java program can run on it.\r\n\r\nMost types of computers will be compatible with a JRE including PCs running on Windows, Macintosh computers, Unix or Linux computers, and large mainframe computers, as well as mobile phones.\r\n\r\nSince it has been around for so long, some of the biggest organisations in the world are built using the language. Many banks, retailers, insurance companies, utilities, and manufacturers all use Java.\r\n\r\nSteve Zara, a programmer for more than 40 years, describes how there is no sign of Java declining in use. Instead, it is an evolving language which almost uniquely combines stability with innovation.\r\n\r\nHighlighting the longevity of the language, Zara states that the code you may have written 15 years ago will run on the most up-to-date JVMs and gain the speed advantage of the latest profiling, native code translating, and memory management.\r\n\r\nexamining the longstanding appeal of Java\r\n\r\nJava is fundamentally object-oriented. The code is so robust because Java objects contain no references to data external to themselves.\r\n\r\nThe language is considered to be very simple; however, it comes with a library of classes that offer commonly used utility functions that most Java programs canât work without.\r\n\r\nJava API, the class library, is as much a part of Java as the language itself. In actuality, the genuine challenge of learning how to use Java isnât learning the language, but learning the API.\r\n\r\nThe language consists of 50 keywords, but the Java API has thousands of classes with tens of thousands of methods you can use in your programs.\r\n\r\nDespite this, developers arenât expected to learn all of the Java API, and the majority of them are only experienced and fluent with a small portion of it.', NULL, 'java_logo_640.jpg', '2021-12-14 08:24:16', 1, 34),
(13, 'Dynamic Programming', 'Dynamic Programming is mainly an optimization over plain recursion. Wherever we see a recursive solution that has repeated calls for same inputs, we can optimize it using Dynamic Programming. The idea is to simply store the results of subproblems, so that we do not have to re-compute them when needed later. This simple optimization reduces time complexities from exponential to polynomial. For example, if we write simple recursive solution for Fibonacci Numbers, we get exponential time complexity and if we optimize it by storing solutions of subproblems, time complexity reduces to linear.', NULL, 'tec.jpg', '2021-12-14 08:49:33', 5, 34),
(18, 'Difference between Stack and Queue', 'Stack : A stack is a linear data structure in which elements can be inserted and deleted only from one side of the list, called the top. A stack follows the LIFO (Last In First Out) principle, i.e., the element inserted at the last is the first element to come out. The insertion of an element into stack is called push operation, and deletion of an element from the stack is called pop operation. In stack we always keep track of the last element present in the list with a pointer called top.\r\nQueue: A queue is a linear data structure in which elements can be inserted only from one side of the list called rear, and the elements can be deleted only from the other side called the front. The queue data structure follows the FIFO (First In First Out) principle, i.e. the element inserted at first in the list, is the first element to be removed from the list. The insertion of an element in a queue is called an enqueue operation and the deletion of an element is called a dequeue operation. In queue we always maintain two pointers, one pointing to the element which was inserted at the first and still present in the list with the front pointer and the second pointer pointing to the element inserted at the last with the rear pointer.', '', 'Stack-vs-Queue.jpg', '2021-12-15 09:33:59', 3, 36),
(22, 'Primitive data types', 'Java is a statically typed language. The base of any programming language is its data types and operators. Java comes with a rich set of both data types and operators, which makes it suitable for any type of programming.\r\n\r\nThere are two categories of data types in Java:\r\n\r\nPrimitive Data Types\r\nNon-Primitive DataTypes\r\n1. Primitive Data Types in Java\r\nAs the name suggests, the programming language pre-defines the primitive data types. Primitive types are the most basic data types available in Java. There are 8 primitive data types in Java: byte, char, short, int, long, float, double and boolean.\r\n\r\nThese data types act as the basic building blocks of data manipulation in Java. Primitive data types have a constraint that they can hold data of the same type and have a fixed size. Primitive data types are also called intrinsic data types. We can also perform operations on primitive data types.', 'public class IntDataType\r\n{\r\n  public static void main(String args[])\r\n  {\r\n    int myNum1, myNum2, result;\r\n    myNum1 = -7000;\r\n    myNum2 = 90000;\r\n    result = myNum1 + myNum2;\r\n    System.out.println(\"Number 1: \" +myNum1);\r\n    System.out.println(\"Number 2: \" +myNum2);\r\n    System.out.println(\"Number 1 + Number 2: \" +result);\r\n  }\r\n}', 'primitive-data-types-in-java.jpg', '2021-12-17 07:41:59', 1, 35),
(23, 'Data Types in Python', 'Built-in Data Types in Python\r\nBinary Types: memoryview, bytearray, bytes\r\nBoolean Type: bool\r\nSet Types: frozenset, set\r\nMapping Type: dict\r\nSequence Types: range, tuple, list\r\nNumeric Types: complex, float, int\r\nText Type: str\r\n1. Python Numbers\r\nWe can find complex numbers, floating point numbers and integers in the category of Python Numbers. Complex numbers are defined as a complex class, floating point numbers are defined as float and integers are defined as an int in Python. There is one more type of datatype in this category, and that is long. It is used to hold longer integers. One will find this datatype only in Python 2.x which was later removed in Python 3.x. \r\n\r\nâType()â function is used to know the class of a value or variable. To check the value for a particular class, âisinstance()â function is used. \r\n\r\nIntegers:\r\nThere is no maximum limit on the value of an integer. The integer can be of any length without any limitation which can go up to the maximum available memory of the system. \r\nIntegers can look like this:\r\n>>> print(123123123123123123123123123123123123123123123123123 + 1)\r\n123123123123123123123123123123123123123123123123124\r\n\r\nFloating Point Number:\r\nThe difference between floating points and integers is decimal points. Floating point number can be represented as â1.0â, and integer can be represented as â1â. It is accurate up to 15 decimal places.\r\nComplex Number:\r\nâx + yjâ is the written form of the complex number. Here y is the imaginary part and x is the real part.\r\n2. Python List\r\nAn ordered sequence of items is called List. It is a very flexible data type in Python. There is no need for the value in the list to be of the same data type. The List is the data type that is highly used data type in Python. List datatype is the most exclusive datatype in Python for containing versatile data. It can easily hold different types of data in Python.  \r\n\r\nIt is effortless to declare a list. The list is enclosed with brackets and commas are used to separate the items. \r\n\r\nA list can look like this:\r\n\r\n>>> a = [5,9.9,âlistâ]\r\n\r\nOne can also alter the value of an element in the list.\r\n\r\n3. Python Tuple\r\nA Tuple is a sequence of items that are in order, and it is not possible to modify the Tuples. The main difference list and tuples are that tuple is immutable, which means it cannot be altered. Tuples are generally faster than the list data type in Python because it cannot be changed or modified like list datatype. The primary use of Tuples is to write-protect data. Tuples can be represented by using parentheses (), and commas are used to separate the items. \r\n\r\nTuples can look like this:\r\n\r\n>>> t = (6,âtupleâ,4+2r)\r\n\r\nIn the case of a tuple, one can use the slicing operator to extract the item, but it will not allow changing the value. ', 'print(123123123123123123123123123123123123123123123123123 + 1)', 'python-data-types.png', '2021-12-17 07:45:30', 2, 35),
(24, 'What is Regression in AI? ujwallll', 'The mathematical approach to find the relationship between two or more variables is known as Regression in AI . Regression is widely used in Machine Learning to predict the behavior of one variable depending upon the value of another variable.\r\n\r\nUnlike the classification models, the regression models output numeric values. It also has continuous values for both dependent and independent variables, and for the most part, Regression is classified as supervised learning.\r\n\r\nTypes of Regression in AI\r\nEach regression technique has some assumptions that you need to fulfil before using them. Here are a few of the types ranging from famous to less known; each of them has its own pros and cons.\r\n\r\nLinear Regression: Linear Regression is considered to be the simplest form of Regression. This type of Regression is applicable when the relationship between the dependent and independent variables is linear in nature. The data is plotted on the graph, and a best-fitted line is calculated using the formula. This line is also known as the line of Regression. The predictions are then made on the basis of this line. ', 'import numpy as np\r\nimport matplotlib.pyplot as plt\r\n\r\ndef estimate_coef(x, y):\r\n	# number of observations/points\r\n	n = np.size(x)\r\n\r\n	# mean of x and y vector\r\n	m_x = np.mean(x)\r\n	m_y = np.mean(y)\r\n\r\n	# calculating cross-deviation and deviation about x\r\n	SS_xy = np.sum(y*x) - n*m_y*m_x\r\n	SS_xx = np.sum(x*x) - n*m_x*m_x\r\n\r\n	# calculating regression coefficients\r\n	b_1 = SS_xy / SS_xx\r\n	b_0 = m_y - b_1*m_x\r\n\r\n	return (b_0, b_1)\r\n\r\ndef plot_regression_line(x, y, b):\r\n	# plotting the actual points as scatter plot\r\n	plt.scatter(x, y, color = \"m\",\r\n			marker = \"o\", s = 30)\r\n\r\n	# predicted response vector\r\n	y_pred = b[0] + b[1]*x\r\n\r\n	# plotting the regression line\r\n	plt.plot(x, y_pred, color = \"g\")\r\n\r\n	# putting labels\r\n	plt.xlabel(\'x\')\r\n	plt.ylabel(\'y\')\r\n\r\n	# function to show plot\r\n	plt.show()\r\n\r\ndef main():\r\n	# observations / data\r\n	x = np.array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])\r\n	y = np.array([1, 3, 2, 5, 7, 8, 8, 9, 10, 12])\r\n\r\n	# estimating coefficients\r\n	b = estimate_coef(x, y)\r\n	print(\"Estimated coefficients:\\nb_0 = {} \\\r\n		\\nb_1 = {}\".format(b[0], b[1]))\r\n\r\n	# plotting regression line\r\n	plot_regression_line(x, y, b)\r\n\r\nif __name__ == \"__main__\":\r\n	main()\r\n', 'regression-in-AI-300x229.png', '2021-12-17 07:48:08', 6, 35),
(25, 'Greedy Algorithm', 'Greedy is an algorithmic paradigm that builds up a solution piece by piece, always choosing the next piece that offers the most obvious and immediate benefit. So the problems where choosing locally optimal also leads to global solution are best fit for Greedy.\r\n\r\nFor example consider the Fractional Knapsack Problem. The local optimal strategy is to choose the item that has maximum value vs weight ratio. This strategy also leads to global optimal solution because we allowed to take fractions of an item.', 'import java.io.*;\r\nimport java.util.*;\r\n\r\nclass GFG {\r\n	static class AdjListNode {\r\n		int vertex, weight;\r\n\r\n		AdjListNode(int v, int w)\r\n		{\r\n			vertex = v;\r\n			weight = w;\r\n		}\r\n		int getVertex() { return vertex; }\r\n		int getWeight() { return weight; }\r\n	}\r\n\r\n	// Function to find the shortest distance of all the\r\n	// vertices from the source vertex S.\r\n	public static int[] dijkstra(\r\n		int V, ArrayList<ArrayList<AdjListNode> > graph,\r\n		int source)\r\n	{\r\n		int[] distance = new int[V];\r\n		for (int i = 0; i < V; i++)\r\n			distance[i] = Integer.MAX_VALUE;\r\n		distance = 0;\r\n\r\n		PriorityQueue<AdjListNode> pq = new PriorityQueue<>(\r\n			(v1, v2) -> v1.getWeight() - v2.getWeight());\r\n		pq.add(new AdjListNode(source, 0));\r\n\r\n		while (pq.size() > 0) {\r\n			AdjListNode current = pq.poll();\r\n\r\n			for (AdjListNode n :\r\n				graph.get(current.getVertex())) {\r\n				if (distance[current.getVertex()]\r\n						+ n.getWeight()\r\n					< distance[n.getVertex()]) {\r\n					distance[n.getVertex()]\r\n						= n.getWeight()\r\n						+ distance[current.getVertex()];\r\n					pq.add(new AdjListNode(\r\n						n.getVertex(),\r\n						distance[n.getVertex()]));\r\n				}\r\n			}\r\n		}\r\n		// If you want to calculate distance from source to\r\n		// a particular target, you can return\r\n		// distance[target]\r\n		return distance;\r\n	}\r\n\r\n	public static void main(String[] args)\r\n	{\r\n		int V = 9;\r\n		ArrayList<ArrayList<AdjListNode> > graph\r\n			= new ArrayList<>();\r\n		for (int i = 0; i < V; i++) {\r\n			graph.add(new ArrayList<>());\r\n		}\r\n		int source = 0;\r\n		graph.get(0).add(new AdjListNode(1, 4));\r\n		graph.get(0).add(new AdjListNode(7, 8));\r\n		graph.get(1).add(new AdjListNode(2, 8));\r\n		graph.get(1).add(new AdjListNode(7, 11));\r\n		graph.get(1).add(new AdjListNode(0, 7));\r\n		graph.get(2).add(new AdjListNode(1, 8));\r\n		graph.get(2).add(new AdjListNode(3, 7));\r\n		graph.get(2).add(new AdjListNode(8, 2));\r\n		graph.get(2).add(new AdjListNode(5, 4));\r\n		graph.get(3).add(new AdjListNode(2, 7));\r\n		graph.get(3).add(new AdjListNode(4, 9));\r\n		graph.get(3).add(new AdjListNode(5, 14));\r\n		graph.get(4).add(new AdjListNode(3, 9));\r\n		graph.get(4).add(new AdjListNode(5, 10));\r\n		graph.get(5).add(new AdjListNode(4, 10));\r\n		graph.get(5).add(new AdjListNode(6, 2));\r\n		graph.get(6).add(new AdjListNode(5, 2));\r\n		graph.get(6).add(new AdjListNode(7, 1));\r\n		graph.get(6).add(new AdjListNode(8, 6));\r\n		graph.get(7).add(new AdjListNode(0, 8));\r\n		graph.get(7).add(new AdjListNode(1, 11));\r\n		graph.get(7).add(new AdjListNode(6, 1));\r\n		graph.get(7).add(new AdjListNode(8, 7));\r\n		graph.get(8).add(new AdjListNode(2, 2));\r\n		graph.get(8).add(new AdjListNode(6, 6));\r\n		graph.get(8).add(new AdjListNode(7, 1));\r\n\r\n		int[] distance = dijkstra(V, graph, source);\r\n		// Printing the Output\r\n		System.out.println(\"Vertex \"\r\n						+ \" Distance from Source\");\r\n		for (int i = 0; i < V; i++) {\r\n			System.out.println(i + \"			 \"\r\n							+ distance[i]);\r\n		}\r\n	}\r\n}\r\n', '1200px-Greedy_algorithm_36_cents.svg.png', '2021-12-17 07:51:48', 3, 36);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(20) NOT NULL,
  `name` varchar(500) NOT NULL,
  `email` varchar(500) NOT NULL,
  `password` varchar(500) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `about` varchar(1000) NOT NULL DEFAULT '''hey I am using TechBlog''',
  `rdate` timestamp NOT NULL DEFAULT current_timestamp(),
  `profile` varchar(200) NOT NULL DEFAULT 'default.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `password`, `gender`, `about`, `rdate`, `profile`) VALUES
(34, 'Riya Vishwa', 'riyav123@gmail.com', '$2a$10$KRG.C.ESTNz44Af5whsv3uXMYgWy/EHKmGxGThzljuOk/afhlyUh2', 'female', '                                                                                                        fserhfgmhgjrh\r\n                                                \r\n                                                ', '2021-12-06 10:28:52', 'pic2.jpg'),
(35, 'Ujwal Yadav', 'uju23@gmail.com', '4444', 'male', '\'hey I am using TechBlog', '2021-12-08 11:04:40', 'default.png'),
(36, 'Sheetal', 'shee12@gmail.com', '123', 'female', 'hello, i am a programmer', '2021-12-15 09:07:45', 'default.png'),
(38, 'urvashi', 'urv11@gmail.com', '1111', 'female', '\'hey I am using TechBlog', '2021-12-18 09:04:52', 'default.png'),
(39, 'sample', 'sam12@gmail.com', '5555', 'male', 'wefqefsefqef3q', '2021-12-23 10:35:48', 'default.png'),
(40, 'gcjbdq', 'bsjss@gmail.com', '3333', 'male', 'dbmwbd,wqbd,mw', '2021-12-23 10:36:31', 'default.png'),
(41, 'Riya Vishwakarma', 'riyavishwa2001@gmail.com', '$2a$10$iTaAdQMutUIjO9Za4DhEv.iCZupJkYdUw2ZFbFYsmntE/cXRR4cnK', 'female', '                                                                                                        dadasawd\r\n                                                \r\n                                                ', '2021-12-30 10:07:02', 'pic2.jpg'),
(42, 'ruru', 'rURU@gmail.com', '$2a$10$uYKhChVPrOQ5Y3cjczQhBe3tkCSU1VZ.JEjUSLdTF12G7s.A4t916', 'female', 'bdhGJASJA', '2022-01-02 08:04:59', 'default.png'),
(43, 'kiki', 'kiki@gmail.com', '$2a$10$KRG.C.ESTNz44Af5whsv3uXMYgWy/EHKmGxGThzljuOk/afhlyUh2', 'female', 'ggggg', '2022-01-02 08:10:04', 'default.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`cid`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `pid` (`pid`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`lid`),
  ADD KEY `pid` (`pid`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`pid`),
  ADD KEY `catId` (`catId`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `cid` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `cid` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `lid` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=145;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `pid` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `posts` (`pid`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `posts` (`pid`),
  ADD CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`id`);

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`catId`) REFERENCES `categories` (`cid`),
  ADD CONSTRAINT `posts_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
