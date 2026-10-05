class BuyerSocialData {
  static final List<Map<String, dynamic>> buyers = [
    {
      'id': 'buyer-001',
      'name': 'अनिल पाटील',
      'username': 'anil.patil',
      'pincode': '411028',
      'area': 'नाशिक शहर',
      'bio': 'AMOLE वर स्थानिक बाजाराशी जोडलेला ग्राहक.',
      'friends': 86,
      'posts': 9,
      'mutual': 3,
      'profileFields': {
        'शहर / सध्याचे ठिकाण': 'नाशिक शहर',
        'मूळ गाव': 'नाशिक',
        'व्यवसाय / प्रोफेशन': 'व्यवसाय',
        'भाषा': 'मराठी, हिंदी',
        'छंद / आवडी': 'क्रिकेट, प्रवास',
      },
      'friendRequestStatus': 'none',
    },
    {
      'id': 'buyer-002',
      'name': 'सुनिता देशमुख',
      'username': 'sunita.deshmukh',
      'pincode': '411028',
      'area': 'पंचवटी, नाशिक',
      'bio': 'स्थानिक वस्तू आणि सेवांना प्राधान्य.',
      'friends': 124,
      'posts': 15,
      'mutual': 1,
      'profileFields': {
        'शहर / सध्याचे ठिकाण': 'पंचवटी, नाशिक',
        'मूळ गाव': 'सिन्नर',
        'व्यवसाय / प्रोफेशन': 'व्यवसाय',
        'भाषा': 'मराठी, हिंदी, इंग्रजी',
        'छंद / आवडी': 'वाचन, प्रवास',
      },
      'friendRequestStatus': 'none',
    },
    {
      'id': 'buyer-003',
      'name': 'राहुल शिंदे',
      'username': 'rahul.shinde',
      'pincode': '411028',
      'area': 'गंगापूर रोड, नाशिक',
      'bio': 'माझा पैसा माझ्या खिशात, आपला बाजार आपल्या लोकांचा.',
      'friends': 158,
      'posts': 21,
      'mutual': 5,
      'profileFields': {
        'शहर / सध्याचे ठिकाण': 'गंगापूर रोड, नाशिक',
        'मूळ गाव': 'येवला',
        'व्यवसाय / प्रोफेशन': 'व्यवसाय',
        'भाषा': 'मराठी, हिंदी, इंग्रजी',
        'छंद / आवडी': 'व्यवसाय, क्रिकेट',
      },
      'friendRequestStatus': 'none',
    },
    {
      'id': 'buyer-004',
      'name': 'प्रिया जोशी',
      'username': 'priya.joshi',
      'pincode': '411028',
      'area': 'इंदिरानगर, नाशिक',
      'bio': 'स्थानिक व्यवसायांना सपोर्ट करणारी AMOLE user.',
      'friends': 97,
      'posts': 12,
      'mutual': 2,
      'profileFields': {
        'शहर / सध्याचे ठिकाण': 'इंदिरानगर, नाशिक',
        'मूळ गाव': 'धुळे',
        'व्यवसाय / प्रोफेशन': 'नोकरी',
        'भाषा': 'मराठी, हिंदी, इंग्रजी',
        'छंद / आवडी': 'संगीत, प्रवास',
      },
      'friendRequestStatus': 'none',
    },
    {
      'id': 'buyer-005',
      'name': 'विकास कुलकर्णी',
      'username': 'vikas.kulkarni',
      'pincode': '411029',
      'area': 'सातपूर, नाशिक',
      'bio': 'AMOLE community मध्ये नवीन.',
      'friends': 42,
      'posts': 4,
      'mutual': 0,
      'profileFields': {
        'शहर / सध्याचे ठिकाण': 'सातपूर, नाशिक',
        'मूळ गाव': 'औरंगाबाद',
        'व्यवसाय / प्रोफेशन': 'नोकरी',
        'भाषा': 'मराठी, हिंदी',
        'छंद / आवडी': 'तंत्रज्ञान, क्रिकेट',
      },
      'friendRequestStatus': 'none',
    },
  ];

  static void sendFriendRequest(String buyerId) {
    final index = buyers.indexWhere((buyer) => buyer['id'] == buyerId);
    if (index != -1) {
      buyers[index]['friendRequestStatus'] = 'pending';
    }
  }

  static void acceptFriendRequest(String buyerId) {
    final index = buyers.indexWhere((buyer) => buyer['id'] == buyerId);
    if (index != -1) {
      buyers[index]['friendRequestStatus'] = 'accepted';
    }
  }

  static void rejectFriendRequest(String buyerId) {
    final index = buyers.indexWhere((buyer) => buyer['id'] == buyerId);
    if (index != -1) {
      buyers[index]['friendRequestStatus'] = 'rejected';
    }
  }
}
