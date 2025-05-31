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
✅ **And** And the cache is less than seven days old
✅ **When** the customer requests to see the feed  
✅ **Then** the app should display the latest feed saved  

### **Scenario 2: Cache is Older than Seven Days**  
✅ **Given** the customer doesn't have connectivity  
✅ **And** there’s a cached version of the feed
✅ **And** And the cache is seven days old or more
✅ **When** the customer requests to see the feed  
✅ **Then** the app should display an error message  

### **Scenario 3: No Cached Feed**  
✅ **Given** the customer doesn't have connectivity  
✅ **And** the cache is empty  
✅ **When** the customer requests to see the feed  
✅ **Then** the app should display an error message  

---

## **Use Cases**

### **Load Feed From Remote Use Case**  
📥 **Data (Input):**  
- URL  

🔹 **Primary Course (Happy Path):**  
1. Execute the **"Load Image Feed"** command with the given URL.  
2. System downloads data from the URL.  
3. System validates the downloaded data.  
4. System creates image feed from the valid data.  
5. System delivers the image feed.  

❌ **Invalid Data – Error Course (Sad Path):**  
- System delivers invalid data error.  

❌ **No Connectivity – Error Course (Sad Path):**  
- System delivers connectivity error.  

---

### **Load Feed From Cache Use Case**  

🔹 **Primary Course (Happy Path):**  
1. Execute the **"Load Image Feed"** command with the above data.  
2. System fetches feed data from the cache.
3. System validates cache is less than seven days old.  
4. System creates image feed from the cached data.  
5. System delivers the image feed.  

❌ **Error Course (Sad Path):**  
1. System delivers error.

❌ **Expired Cache Course (Sad Path):**  
1. System deletes cache.
2. System delivers no feed images.

❌ **Empty Cache Course (Sad Path):**  
1. System delivers no feed images.  

---

### **Cache Feed Use Case**  
📥 **Data (Input):**  
- Image Feed  

🔹 **Primary Course (Happy Path):**  
1. Execute the **"Save Image Feed"** command with the provided feed items.  
2. System deletes old cache data.
3. System encodes image feed.  
4. System timestamps the new cache.  
5. System saves new cache data.
6. System delivers a success message.  

❌ **Deleting Error Course (Sad Path):**  
1. System delivers error.

❌ **Saving Error Course (Sad Path):**  
1. System delivers error.

### Feed Image

| Property        | Type                |
|-----------------|---------------------|
| `id`            | `UUID`              |
| `description`   | `String` (optional) |
| `location`      | `String` (optional) |
| `url`           | `URL`               |


