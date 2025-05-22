# 📸 Image Feed App - Image Feed Feature  

[![CI](https://github.com/kuzeng/ImageFeedApp/actions/workflows/CI.yml/badge.svg)](https://github.com/kuzeng/ImageFeedApp/actions/workflows/CI.yml)

## **Story: Customer Requests to See Their Image Feed**  

### **Narrative #1: Online Customer**  
**As an online customer,**  
I want the app to automatically load my latest image feed,  
So I can always enjoy the newest images of my friends.  

#### **Scenarios (Acceptance Criteria)**  
✅ **Given** the customer has connectivity  
✅ **When** the customer requests to see the feed  
✅ **Then** the app should display the latest feed from the remote server  
✅ **And** replace the cache with the new feed  

---

### **Narrative #2: Offline Customer**  
**As an offline customer,**  
I want the app to show the latest saved version of my image feed,  
So I can always enjoy images of my friends.  

#### **Scenarios (Acceptance Criteria)**  

### **Scenario 1: Display Cached Feed**  
✅ **Given** the customer doesn't have connectivity  
✅ **And** there’s a cached version of the feed  
✅ **When** the customer requests to see the feed  
✅ **Then** the app should display the latest feed saved  

### **Scenario 2: No Cached Feed**  
✅ **Given** the customer doesn't have connectivity  
✅ **And** the cache is empty  
✅ **When** the customer requests to see the feed  
✅ **Then** the app should display an error message  

---

## **Use Cases**

### **Load Feed Use Case**  
📥 **Data (Input):**  
- URL  

🔹 **Primary Course (Happy Path):**  
1. Execute the **"Load Feed Items"** command with the given URL.  
2. System downloads data from the URL.  
3. System validates the downloaded data.  
4. System creates feed items from the valid data.  
5. System delivers the feed items.  

❌ **Invalid Data – Error Course (Sad Path):**  
- System delivers an error.  

❌ **No Connectivity – Error Course (Sad Path):**  
- System delivers an error.  

---

### **Load Feed Fallback (Cache) Use Case**  
📥 **Data (Input):**  
- Max age  

🔹 **Primary Course (Happy Path):**  
1. Execute the **"Retrieve Feed Items"** command with the given max age.  
2. System fetches feed data from the cache.  
3. System creates feed items from the cached data.  
4. System delivers the feed items.  

❌ **No Cache – Error Course (Sad Path):**  
- System delivers no feed items.  

---

### **Save Feed Items Use Case**  
📥 **Data (Input):**  
- Feed items  

🔹 **Primary Course (Happy Path):**  
1. Execute the **"Save Feed Items"** command with the provided feed items.  
2. System encodes feed items.  
3. System timestamps the new cache.  
4. System replaces the cache with new data.  
5. System delivers a success message.  

