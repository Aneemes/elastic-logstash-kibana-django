# Log monitoring Django application to ELK with filebeat

Logging is a critical aspect of any application, providing insights into its behavior, errors, and performance. The ELK stack, consisting of Elasticsearch, Logstash, and Kibana, is a powerful solution for centralized logging and log analysis. Filebeat is often used to ship logs from various sources to Elasticsearch.

In a Django application, integrating ELK with Filebeat allows for efficient monitoring, troubleshooting, and visualization of logs. This architecture explanation outlines the components and workflow involved in ELK logging with Filebeat in a Django environment.

This project illustrates how to set up monitoring for a Django application using the ELK (Elasticsearch, Logstash, Kibana) stack along with Filebeat for log shipping.

## Components:

### 1. Django Application:

The Django application generates logs containing information about requests, database queries, errors, and other events. These logs are essential for understanding the application's behavior and identifying issues.

### 2. Filebeat:

Filebeat is a lightweight log shipper that reads log files from specified paths and forwards them to various outputs. In the context of Django and ELK, Filebeat is configured to read Django application logs and send them to Elasticsearch for indexing.

### 3. Elasticsearch:

Elasticsearch is a distributed search and analytics engine. It stores and indexes the logs sent by Filebeat. Elasticsearch provides powerful search capabilities and efficient storage for large volumes of logs.

### 4. Logstash (Optional):

Logstash can be used as an intermediary step between Filebeat and Elasticsearch. It allows for additional log processing, parsing, and enrichment before indexing logs in Elasticsearch. While optional, Logstash can be beneficial for more complex log processing requirements.

### 5. Kibana:

Kibana is a web-based user interface for Elasticsearch. It provides a visually appealing and interactive platform for exploring, analyzing, and visualizing logs. Kibana allows users to create custom dashboards, graphs, and visualizations to gain insights into log data.

## Workflow:

1. **Django Application Logging:**
   - The Django application generates logs as per its logging configuration.
   - Logs can include information about HTTP requests, database queries, error traces, and other relevant events.

2. **Filebeat Configuration:**
   - Filebeat is configured to monitor the specific log file paths within the Django application.
   - The configuration also includes the Elasticsearch output, specifying where to send the logs.

3. **Filebeat Log Shipping:**
   - Filebeat reads the logs from the configured paths and ships them to Elasticsearch through Logstash.

4. **Elasticsearch Indexing:**
   - Elasticsearch receives the logs from Filebeat and indexes them.
   - Each log entry becomes a searchable document within Elasticsearch.

5. **Kibana Visualization:**
   - Kibana is used to create index patterns and define how log data should be visualized.
   - Users can explore logs, build dashboards, and set up alerts based on the data stored in Elasticsearch.

## Benefits:

1. **Centralized Logging:**
   - All logs from the Django application are centralized in Elasticsearch, providing a unified view of application activity.

2. **Real-time Monitoring:**
   - Log data is sent in near real-time, allowing for quick detection and response to issues as they occur.

3. **Advanced Search and Analysis:**
   - Elasticsearch's powerful search capabilities enable advanced querying and analysis of log data.

4. **Visualization and Dashboards:**
   - Kibana facilitates the creation of custom dashboards and visualizations, providing a user-friendly interface for log analysis.

5. **Scalability:**
   - ELK stack is scalable, allowing for handling large amounts of log data efficiently.

By adopting ELK logging with Filebeat in a Django application, we can enhance their ability to monitor and troubleshoot issues effectively, leading to improved application reliability and performance.

## Prerequisites

This project illustrates how to set up monitoring for a Django application using the ELK (Elasticsearch, Logstash, Kibana) stack along with Filebeat for log shipping.

Before you start, make sure you have the following components installed:

- Docker
- Docker Compose

## Getting Started

1. Build and start the ELK stack and Filebeat containers using Docker Compose:

   ```
   docker-compose up -d
   ```

   This will spin up the Api, Elasticsearch, Logstash, Kibana, and Filebeat containers.

2. Open Kibana in your browser:

   Visit [http://localhost:5601/](http://localhost:5601/) and configure the index pattern for your Django logs.

## Custom Log Formatting

While Filebeat can perform actions to prepare logs for Elasticsearch, it's advantageous to preprocess logs within the Django application itself. By utilizing a custom log formatter, we can structure log entries to include additional contextual information.

In this Django project, we have custom log formatter, CustomisedJSONFormatter (at `src/testlogs/loggers.py`), to shape log entries before they are sent to the ELK stack. And its configured for logging handling in the `settings.py`. With this JSONFormatter inplace, the logs are going to come out the following format:

```
{"message": "log oneee", "timestamp": "2020-04-26T19:35:59.427098+00:00", "level": "INFO", "app_id": "testlogs", "context": {"random": 68, "name": "testlogs.views", "filename": "views.py", "logdemo": "index", "msecs": 426.8479347229004}}
```

And then for shipping the filebeat logs to the elasticsearch we have a pipeline configuration for logstash which is at: `.docker/logstash/pipeline/logstash.conf`


