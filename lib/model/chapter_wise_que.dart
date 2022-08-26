import 'package:moneytree/model/chapter_model.dart';
import 'package:moneytree/model/que_model.dart';
import 'package:moneytree/utils/constants/icon_constant.dart';

class ChapterQueList {
  static List<QueModel> getQuestions({String id}) {
    return questionsList
        .where((element) => element.chapter_id == id)
        .first
        .queList;
  }

  static String getChapterName({String id}) {
    return questionsList
        .where((element) => element.chapter_id == id)
        .first
        .chapter_name;
  }

  static List<String> getTaskFromId({String id}) {
    return questionsList
        .where((element) => element.chapter_id == id)
        .first
        .tasks;
  }

  static void resetQue() {
    questionsList.clear();
    questionsListPreset.forEach((element) {
      List<QueModel> tempQueList = [];
      element.queList.forEach((que) {
        que.rank_a = '';
        que.rank_b = '';
        que.rank_c = '';
        que.rank_d = '';
        que.userId = '';
        que.result = '';
        tempQueList.add(que);
      });
      questionsList.add(ChapterModel(
          icon: element.icon,
          tasks: element.tasks,
          chapter_name: element.chapter_name,
          chapter_id: element.chapter_id,
          queList: tempQueList));
    });
  }

  static List<ChapterModel> questionsList = [
    ChapterModel(
        chapter_id: '1',
        chapter_name: 'Making Decisions',
        icon: IconConstant.MARKETING,
        queList: [
          QueModel(
              chapter_id: '1',
              que_id: '1',
              chapter_name: 'Making Decisions',
              que: 'What is System 1 of the brain',
              que_type: '1',
              ans: 'option_a',
              option_a: 'Quick, instinctive and impulsive',
              option_b: 'Slower, logical and calculating',
              result: '',
              userId: ''),
          QueModel(
              chapter_id: '1',
              que_id: '2',
              chapter_name: 'Making Decisions',
              que: 'What is System 2 of the brain',
              que_type: '1',
              ans: 'option_b',
              option_a: 'Quick, instinctive and impulsive',
              option_b: 'Slower, logical and calculating',
              result: '',
              userId: ''),
          QueModel(
              chapter_id: '1',
              que_id: '3',
              chapter_name: 'Making Decisions',
              que:
                  'Phineas is looking at different ways to invest his savings, which system should he use?',
              que_type: '1',
              ans: 'option_b',
              option_a: 'System 1',
              option_b: 'System 2',
              result: '',
              userId: ''),
          QueModel(
              chapter_id: '1',
              que_id: '4',
              chapter_name: 'Making Decisions',
              que:
                  'Ferb is looking to order a meal from a restaurant, which system should he use?',
              que_type: '1',
              ans: 'option_a',
              option_a: 'System 1',
              option_b: 'System 2',
              result: '',
              userId: ''),
        ],
        tasks: [
          'Use System 2 to make a decision today'
        ]),
    ChapterModel(
        chapter_id: '2',
        chapter_name: 'Making Money',
        icon: IconConstant.MAKING_MONEY,
        queList: [
          QueModel(
              chapter_id: '2',
              que_id: '5',
              chapter_name: 'Making Decisions',
              que: 'What is the biggest problem in choosing a job?',
              que_type: '1',
              ans: 'option_a',
              option_a:
                  'Finding a job that fulfills your personal interests while still paying the bills',
              option_b:
                  'Finding a job that pays lots of money for you to spend',
              option_c:
                  'Finding a job that has a low workload so you can relax',
              result: '',
              userId: ''),
          QueModel(
              chapter_id: '2',
              que_id: '6',
              chapter_name: 'Making Money',
              que: 'Order the four steps to finding a job',
              que_type: '2',
              ans: '1,2,3,4',
              option_a: 'Identify interests',
              option_b: 'Determine strengths',
              option_c: 'Ask an expert',
              option_d: 'Work experience',
              rank_a: '',
              rank_b: '',
              rank_c: '',
              rank_d: '',
              result: '',
              userId: '')
        ],
        tasks: [
          'Identify your own strengths and passions – then ask family and friends and compare.',
          'Visit [The Bright Network Website] and find some viable career paths',
          'Create a LinkedIn profile'
        ]),
    ChapterModel(
        chapter_id: '3',
        chapter_name: 'Finding a Job',
        icon: IconConstant.FINDING_JOB,
        queList: [
          QueModel(
              chapter_id: '3',
              que_id: '7',
              chapter_name: 'Finding a Job',
              que: 'What are the six sections of your resume',
              que_type: '3',
              ans: 'option_a,option_b,option_c,option_d,option_e,option_f',
              option_a: 'About me',
              option_b: 'Awards and certifications',
              option_c: 'Work experience',
              option_d: 'Education',
              option_e: 'Projects',
              option_f: 'Contact details',
              option_g: 'Fun facts',
              option_h: 'Hobbies',
              option_i: 'Favourite subjects',
              option_j: 'Career goals',
              option_k: 'References',
              result: '',
              userId: ''),
          QueModel(
              chapter_id: '3',
              que_id: '8',
              chapter_name: 'Finding a Job',
              que: 'What is one way to prepare for an interview',
              que_type: '3',
              // ans: 'option_a,option_c',
              ans: 'option_a,option_c',
              option_a: 'Mock interview',
              option_b: 'Asking the company for potential questions',
              option_c: 'Researching the employer',
              result: '',
              userId: '')
        ],
        tasks: [
          'Create your own resume',
          'Have a friend or family member give you a mock interview for a company that you’d like to work for. Prepare like it was the real thing.'
        ]),
    ChapterModel(
        chapter_id: '4',
        chapter_name: 'Budgeting',
        icon: IconConstant.BUDGETING,
        queList: [
          QueModel(
              chapter_id: '4',
              que_id: '9',
              chapter_name: 'Budgeting',
              que:
                  'How much of your after tax income should you save for investing',
              que_type: '1',
              ans: 'option_b',
              option_a: '5%',
              option_b: '10%',
              option_c: '15%',
              option_d: '20%',
              result: '',
              userId: ''),
          QueModel(
              chapter_id: '4',
              que_id: '10',
              chapter_name: 'Budgeting',
              que:
                  'How much of your after tax income should you add to a rainy day fund',
              que_type: '1',
              ans: 'option_a',
              option_a: '5%',
              option_b: '10%',
              option_c: '7.5%',
              option_d: '15%',
              result: '',
              userId: '')
        ],
        tasks: [
          'Document how much money you earn (whether that be allowance or through chores)',
          'Save 10% every month. Another 5% for a “rainy-day” fund and 5 more for something you’d like to buy.'
        ]),
    ChapterModel(
        chapter_id: '5',
        chapter_name: 'Financing University',
        icon: IconConstant.FINANCING_UNIVERSITY,
        queList: [
          QueModel(
              chapter_id: '5',
              que_id: '11',
              chapter_name: 'Financing University',
              que: 'What are the three ways to pay for university',
              que_type: '5',
              ans: 'income,loans,scholarships',
              blank1: '1',
              part1: ' - based repayments, student ',
              blank2: '1',
              part2: ' and ',
              blank3: '1',
              option_a: '',
              result: '',
              userId: '')
          // QueModel(
          //     chapter_id: '5',
          //     que_id: '11',
          //     chapter_name: 'Financing University',
          //     que: 'What are the three ways to pay for university',
          //     que_type: '5',
          //     ans: 'option_a,option_b,option_c',
          //     option_a: 'Income-based repayments',
          //     option_b: 'Student loans',
          //     option_c: 'Scholarships',
          //     result: '',
          //     userId: '')
        ],
        tasks: [
          'Have a conversation with your parents about paying for college. Will they pay? Explore the different options to pay – student loans and income based repayments.',
          'Find scholarships you may be eligible for and apply to them.'
        ]),
    ChapterModel(
        chapter_id: '6',
        chapter_name: 'Taxes',
        icon: IconConstant.TAXES,
        queList: [
          QueModel(
              chapter_id: '6',
              que_id: '21',
              chapter_name: 'Taxes',
              que: 'Which of the following are direct taxes',
              que_type: '3',
              ans: 'option_a,option_c,option_d',
              option_a: 'Income tax',
              option_b: 'VAT',
              option_c: 'Wealth tax',
              option_d: 'Personal property tax',
              result: '',
              userId: ''),
          QueModel(
              chapter_id: '6',
              que_id: '12',
              chapter_name: 'Taxes',
              que: 'Which of the following are indirect taxes',
              que_type: '3',
              ans: 'option_b,option_c,option_d',
              option_a: 'Personal property tax',
              option_b: 'VAT',
              option_c: 'Sales tax',
              option_d: 'Service tax',
              result: '',
              userId: ''),
          QueModel(
              chapter_id: '6',
              que_id: '13',
              chapter_name: 'Budgeting',
              que:
                  'Using a progressive tax system, any income from \$10,000 to \$20,000 is taxed at 10%. Anything below that is untaxed. Johnny earns \$15000 gross income, what is his after-tax income?',
              que_type: '1',
              ans: 'option_a',
              option_a: '\$14500',
              option_b: '\$13500',
              option_c: '\$1500',
              option_d: '\$500',
              result: '',
              userId: '')
        ],
        tasks: []),
    ChapterModel(
        chapter_id: '7',
        chapter_name: 'Credit and Debit',
        icon: IconConstant.CREDIT_DEBIT,
        queList: [
          QueModel(
              chapter_id: '7',
              que_id: '14',
              chapter_name: 'Credit and Debit',
              que: 'What is credit',
              que_type: '5',
              ans: 'borrower,interest',
              part1: 'A contract where the ',
              blank2: '1',
              blank3: '1',
              part2: ' repays the lender, often with ',
              option_a:
                  'A contract where the _______ repays the lender, often with _________',
              result: '',
              userId: ''),
          // QueModel(
          //     chapter_id: '7',
          //     que_id: '14',
          //     chapter_name: 'Credit and Debit',
          //     que: 'What is credit',
          //     que_type: '4',
          //     ans: 'borrower,interest',
          //     option_a:
          //         'A contract where the _______ repays the lender, often with _________',
          //     result: '',
          //     userId: ''),
          QueModel(
              chapter_id: '7',
              que_id: '15',
              chapter_name: 'Credit and Debit',
              que: 'What is debit',
              que_type: '1',
              ans: 'option_a',
              option_a: 'The money you spend from your own savings',
              result: '',
              userId: ''),
          QueModel(
              chapter_id: '7',
              que_id: '16',
              chapter_name: 'Credit and Debit',
              que: 'What are the advantages of a credit card',
              que_type: '3',
              ans: 'option_a,option_b,option_c',
              option_a: 'Discounts',
              option_b: 'Travel miles',
              option_c: 'Opportunity to build up your credit score',
              option_d: 'Better for people who aren’t good with spending',
              result: '',
              userId: ''),
          QueModel(
              chapter_id: '7',
              que_id: '17',
              chapter_name: 'Credit and Debit',
              que:
                  'Mike is responsible with his finances: he knows how much to save, where to spend and where not to spend. He never spends more than he can afford. Should Mike get a credit or debit card?',
              que_type: '1',
              ans: 'option_a',
              option_a: 'Credit',
              option_b: 'Debit',
              result: '',
              userId: ''),
          QueModel(
              chapter_id: '7',
              que_id: '18',
              chapter_name: 'Credit and Debit',
              que:
                  'Sam makes sure to save some of his money, but he knows he can get carried away at times and spend more than he should. Which card should Sam get?',
              que_type: '1',
              ans: 'option_a',
              option_a: 'Debit',
              option_b: 'Credit',
              result: '',
              userId: '')
        ],
        tasks: [
          'Apply for a debit and credit card – use the credit card on small purchases to help build up your credit score.'
        ]),
    ChapterModel(
        chapter_id: '8',
        chapter_name: 'Insurance',
        icon: IconConstant.INSURANCE,
        queList: [
          QueModel(
              chapter_id: '8',
              que_id: '19',
              chapter_name: 'Insurance',
              que: 'What is the point of insurance?',
              que_type: '5',
              ans: 'financial',
              part1: 'To protect from possible ',
              blank2: '1',
              part2: ' losses',
              option_a: '',
              result: '',
              userId: '')
          // QueModel(
          //     chapter_id: '8',
          //     que_id: '19',
          //     chapter_name: 'Insurance',
          //     que: 'What is the point of insurance? [FILL IN THE GAP]',
          //     que_type: '4',
          //     ans: 'financial',
          //     option_a: 'To protect from possible _________ losses',
          //     result: '',
          //     userId: '')
        ],
        tasks: [
          'Talk to your parents about the insurance policies they have and potentially identify any that they don’t have and should get.'
        ]),
    ChapterModel(
        chapter_id: '9',
        chapter_name: 'Investing',
        icon: IconConstant.INVESTING,
        queList: [
          QueModel(
              chapter_id: '9',
              que_id: '20',
              chapter_name: 'Investing',
              que:
                  'Rank the different investments in terms of risk (low to high)',
              que_type: '2',
              ans: '1,2,3',
              rank_a: '',
              rank_b: '',
              rank_c: '',
              option_a: 'Savings account',
              option_b: 'Bonds',
              option_c: 'Stocks',
              result: '',
              userId: '')
        ],
        tasks: [
          'Try putting a small amount of your savings into an ETF and track its value',
          'Put the rest of your money into a savings account'
        ]),
    ChapterModel(
        chapter_id: '10',
        chapter_name: 'Crypto',
        icon: IconConstant.CRYPTO,
        queList: [
          QueModel(
              chapter_id: '10',
              que_id: '21',
              chapter_name: 'Crypto',
              que: 'Which of the following are benefits of crypto',
              que_type: '1',
              ans: 'option_a',
              option_a: 'Decentralized',
              option_b: 'More secure',
              option_c: 'Easier to use',
              result: '',
              userId: ''),
        ],
        tasks: [
          'Create a crypto wallet and put a small amount of money into a crypto currency',
          'Look at the price history of Bitcoin and future forecasts, is it a good investment?'
        ]),
  ];
}

List<ChapterModel> questionsListPreset = [
  ChapterModel(
      chapter_id: '1',
      chapter_name: 'Making Decisions',
      icon: IconConstant.MARKETING,
      queList: [
        QueModel(
            chapter_id: '1',
            que_id: '1',
            chapter_name: 'Making Decisions',
            que: 'What is System 1 of the brain',
            que_type: '1',
            ans: 'option_a',
            option_a: 'Quick, instinctive and impulsive',
            option_b: 'Slower, logical and calculating',
            result: '',
            userId: ''),
        QueModel(
            chapter_id: '1',
            que_id: '2',
            chapter_name: 'Making Decisions',
            que: 'What is System 2 of the brain',
            que_type: '1',
            ans: 'option_b',
            option_a: 'Quick, instinctive and impulsive',
            option_b: 'Slower, logical and calculating',
            result: '',
            userId: ''),
        QueModel(
            chapter_id: '1',
            que_id: '3',
            chapter_name: 'Making Decisions',
            que:
                'Phineas is looking at different ways to invest his savings, which system should he use?',
            que_type: '1',
            ans: 'option_b',
            option_a: 'System 1',
            option_b: 'System 2',
            result: '',
            userId: ''),
        QueModel(
            chapter_id: '1',
            que_id: '4',
            chapter_name: 'Making Decisions',
            que:
                'Ferb is looking to order a meal from a restaurant, which system should he use?',
            que_type: '1',
            ans: 'option_a',
            option_a: 'System 1',
            option_b: 'System 2',
            result: '',
            userId: ''),
      ],
      tasks: [
        'Use System 2 to make a decision today'
      ]),
  ChapterModel(
      chapter_id: '2',
      chapter_name: 'Making Money',
      icon: IconConstant.MAKING_MONEY,
      queList: [
        QueModel(
            chapter_id: '2',
            que_id: '5',
            chapter_name: 'Making Decisions',
            que: 'What is the biggest problem in choosing a job?',
            que_type: '1',
            ans: 'option_a',
            option_a:
                'Finding a job that fulfills your personal interests while still paying the bills',
            option_b: 'Finding a job that pays lots of money for you to spend',
            option_c: 'Finding a job that has a low workload so you can relax',
            result: '',
            userId: ''),
        QueModel(
            chapter_id: '2',
            que_id: '6',
            chapter_name: 'Making Money',
            que: 'Order the four steps to finding a job',
            que_type: '2',
            ans: '1,2,3,4',
            option_a: 'Identify interests',
            option_b: 'Determine strengths',
            option_c: 'Ask an expert',
            option_d: 'Work experience',
            rank_a: '',
            rank_b: '',
            rank_c: '',
            rank_d: '',
            result: '',
            userId: '')
      ],
      tasks: [
        'Identify your own strengths and passions – then ask family and friends and compare.',
        'Visit [The Bright Network Website] and find some viable career paths',
        'Create a LinkedIn profile'
      ]),
  ChapterModel(
      chapter_id: '3',
      chapter_name: 'Finding a Job',
      icon: IconConstant.FINDING_JOB,
      queList: [
        QueModel(
            chapter_id: '3',
            que_id: '7',
            chapter_name: 'Finding a Job',
            que: 'What are the six sections of your resume',
            que_type: '3',
            ans: 'option_a,option_b,option_c,option_d,option_e,option_f',
            option_a: 'About me',
            option_b: 'Awards and certifications',
            option_c: 'Work experience',
            option_d: 'Education',
            option_e: 'Projects',
            option_f: 'Contact details',
            option_g: 'Fun facts',
            option_h: 'Hobbies',
            option_i: 'Favourite subjects',
            option_j: 'Career goals',
            option_k: 'References',
            result: '',
            userId: ''),
        QueModel(
            chapter_id: '3',
            que_id: '8',
            chapter_name: 'Finding a Job',
            que: 'What is one way to prepare for an interview',
            que_type: '3',
            ans: 'option_a,option_c',
            option_a: 'Mock interview',
            option_b: 'Asking the company for potential questions',
            option_c: 'Researching the employer',
            result: '',
            userId: '')
      ],
      tasks: [
        'Create your own resume',
        'Have a friend or family member give you a mock interview for a company that you’d like to work for. Prepare like it was the real thing.'
      ]),
  ChapterModel(
      chapter_id: '4',
      chapter_name: 'Budgeting',
      icon: IconConstant.BUDGETING,
      queList: [
        QueModel(
            chapter_id: '4',
            que_id: '9',
            chapter_name: 'Budgeting',
            que:
                'How much of your after tax income should you save for investing',
            que_type: '1',
            ans: 'option_b',
            option_a: '5%',
            option_b: '10%',
            option_c: '15%',
            option_d: '20%',
            result: '',
            userId: ''),
        QueModel(
            chapter_id: '4',
            que_id: '10',
            chapter_name: 'Budgeting',
            que:
                'How much of your after tax income should you add to a rainy day fund',
            que_type: '1',
            ans: 'option_a',
            option_a: '5%',
            option_b: '10%',
            option_c: '7.5%',
            option_d: '15%',
            result: '',
            userId: '')
      ],
      tasks: [
        'Document how much money you earn (whether that be allowance or through chores)',
        'Save 10% every month. Another 5% for a “rainy-day” fund and 5 more for something you’d like to buy.'
      ]),
  ChapterModel(
      chapter_id: '5',
      chapter_name: 'Financing University',
      icon: IconConstant.FINANCING_UNIVERSITY,
      queList: [
        QueModel(
            chapter_id: '5',
            que_id: '11',
            chapter_name: 'Financing University',
            que: 'What are the three ways to pay for university',
            que_type: '5',
            ans: 'income,loans,scholarships',
            blank1: '1',
            part1: ' - based repayments, student ',
            blank2: '1',
            part2: ' and ',
            blank3: '1',
            option_a: '',
            result: '',
            userId: '')
        // QueModel(
        //     chapter_id: '5',
        //     que_id: '11',
        //     chapter_name: 'Financing University',
        //     que: 'What are the three ways to pay for university',
        //     que_type: '5',
        //     ans: 'option_a,option_b,option_c',
        //     option_a: 'Income-based repayments',
        //     option_b: 'Student loans',
        //     option_c: 'Scholarships',
        //     result: '',
        //     userId: '')
      ],
      tasks: [
        'Have a conversation with your parents about paying for college. Will they pay? Explore the different options to pay – student loans and income based repayments.',
        'Find scholarships you may be eligible for and apply to them.'
      ]),
  ChapterModel(
      chapter_id: '6',
      chapter_name: 'Taxes',
      icon: IconConstant.TAXES,
      queList: [
        QueModel(
            chapter_id: '6',
            que_id: '21',
            chapter_name: 'Taxes',
            que: 'Which of the following are direct taxes',
            que_type: '3',
            ans: 'option_a,option_c,option_d',
            option_a: 'Income tax',
            option_b: 'VAT',
            option_c: 'Wealth tax',
            option_d: 'Personal property tax',
            result: '',
            userId: ''),
        QueModel(
            chapter_id: '6',
            que_id: '12',
            chapter_name: 'Taxes',
            que: 'Which of the following are indirect taxes',
            que_type: '3',
            ans: 'option_b,option_c,option_d',
            option_a: 'Personal property tax',
            option_b: 'VAT',
            option_c: 'Sales tax',
            option_d: 'Service tax',
            result: '',
            userId: ''),
        QueModel(
            chapter_id: '6',
            que_id: '13',
            chapter_name: 'Budgeting',
            que:
                'Using a progressive tax system, any income from \$10,000 to \$20,000 is taxed at 10%. Anything below that is untaxed. Johnny earns \$15000 gross income, what is his after-tax income?',
            que_type: '1',
            ans: 'option_a',
            option_a: '\$14500',
            option_b: '\$13500',
            option_c: '\$1500',
            option_d: '\$500',
            result: '',
            userId: '')
      ],
      tasks: []),
  ChapterModel(
      chapter_id: '7',
      chapter_name: 'Credit and Debit',
      icon: IconConstant.CREDIT_DEBIT,
      queList: [
        QueModel(
            chapter_id: '7',
            que_id: '14',
            chapter_name: 'Credit and Debit',
            que: 'What is credit',
            que_type: '5',
            ans: 'borrower,interest',
            part1: 'A contract where the ',
            blank2: '1',
            blank3: '1',
            part2: ' repays the lender, often with ',
            option_a:
                'A contract where the _______ repays the lender, often with _________',
            result: '',
            userId: ''),
        // QueModel(
        //     chapter_id: '7',
        //     que_id: '14',
        //     chapter_name: 'Credit and Debit',
        //     que: 'What is credit',
        //     que_type: '4',
        //     ans: 'borrower,interest',
        //     option_a:
        //         'A contract where the _______ repays the lender, often with _________',
        //     result: '',
        //     userId: ''),
        QueModel(
            chapter_id: '7',
            que_id: '15',
            chapter_name: 'Credit and Debit',
            que: 'What is debit',
            que_type: '1',
            ans: 'option_a',
            option_a: 'The money you spend from your own savings',
            result: '',
            userId: ''),
        QueModel(
            chapter_id: '7',
            que_id: '16',
            chapter_name: 'Credit and Debit',
            que: 'What are the advantages of a credit card',
            que_type: '3',
            ans: 'option_a,option_b,option_c',
            option_a: 'Discounts',
            option_b: 'Travel miles',
            option_c: 'Opportunity to build up your credit score',
            option_d: 'Better for people who aren’t good with spending',
            result: '',
            userId: ''),
        QueModel(
            chapter_id: '7',
            que_id: '17',
            chapter_name: 'Credit and Debit',
            que:
                'Mike is responsible with his finances: he knows how much to save, where to spend and where not to spend. He never spends more than he can afford. Should Mike get a credit or debit card?',
            que_type: '1',
            ans: 'option_a',
            option_a: 'Credit',
            option_b: 'Debit',
            result: '',
            userId: ''),
        QueModel(
            chapter_id: '7',
            que_id: '18',
            chapter_name: 'Credit and Debit',
            que:
                'Sam makes sure to save some of his money, but he knows he can get carried away at times and spend more than he should. Which card should Sam get?',
            que_type: '1',
            ans: 'option_a',
            option_a: 'Debit',
            option_b: 'Credit',
            result: '',
            userId: '')
      ],
      tasks: [
        'Apply for a debit and credit card – use the credit card on small purchases to help build up your credit score.'
      ]),
  ChapterModel(
      chapter_id: '8',
      chapter_name: 'Insurance',
      icon: IconConstant.INSURANCE,
      queList: [
        QueModel(
            chapter_id: '8',
            que_id: '19',
            chapter_name: 'Insurance',
            que: 'What is the point of insurance?',
            que_type: '5',
            ans: 'financial',
            part1: 'To protect from possible ',
            blank2: '1',
            part2: ' losses',
            option_a: '',
            result: '',
            userId: '')
        // QueModel(
        //     chapter_id: '8',
        //     que_id: '19',
        //     chapter_name: 'Insurance',
        //     que: 'What is the point of insurance? [FILL IN THE GAP]',
        //     que_type: '4',
        //     ans: 'financial',
        //     option_a: 'To protect from possible _________ losses',
        //     result: '',
        //     userId: '')
      ],
      tasks: [
        'Talk to your parents about the insurance policies they have and potentially identify any that they don’t have and should get.'
      ]),
  ChapterModel(
      chapter_id: '9',
      chapter_name: 'Investing',
      icon: IconConstant.INVESTING,
      queList: [
        QueModel(
            chapter_id: '9',
            que_id: '20',
            chapter_name: 'Investing',
            que:
                'Rank the different investments in terms of risk (low to high)',
            que_type: '2',
            ans: '1,2,3',
            rank_a: '',
            rank_b: '',
            rank_c: '',
            option_a: 'Savings account',
            option_b: 'Bonds',
            option_c: 'Stocks',
            result: '',
            userId: '')
      ],
      tasks: [
        'Try putting a small amount of your savings into an ETF and track its value',
        'Put the rest of your money into a savings account'
      ]),
  ChapterModel(
      chapter_id: '10',
      chapter_name: 'Crypto',
      icon: IconConstant.CRYPTO,
      queList: [
        QueModel(
            chapter_id: '10',
            que_id: '21',
            chapter_name: 'Crypto',
            que: 'Which of the following are benefits of crypto',
            que_type: '1',
            ans: 'option_a',
            option_a: 'Decentralized',
            option_b: 'More secure',
            option_c: 'Easier to use',
            result: '',
            userId: ''),
      ],
      tasks: [
        'Create a crypto wallet and put a small amount of money into a crypto currency',
        'Look at the price history of Bitcoin and future forecasts, is it a good investment?'
      ]),
];

/*
* 1 -> Single option answer
* 2 -> Series of answer
* 3 -> Multiple answer
* 4 -> Fill in the blank answer
* */
