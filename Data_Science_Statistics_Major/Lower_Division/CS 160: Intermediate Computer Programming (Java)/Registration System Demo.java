/**
 * StreamRegistryDemo
 *
 * Demonstrates advanced Java Stream API usage in a neutral domain.
 *
 * Concepts shown:
 * - Object-oriented design with records and enums
 * - Exception-safe registration logic (capacity + duplicate protection)
 * - Stream-based analytics:
 *   - grouping by multiple keys
 *   - mapping and transformation
 *   - top-N selection per group
 *   - summary statistics and filtered averages
 *
 * This example was written as a portfolio demonstration of
 * intermediate-to-advanced Java programming patterns.
 */


import java.util.*;
import java.util.stream.Collectors;

public class StreamRegistryDemo {

  // neutral domain model

  enum Group { TECH, SCIENCE, ARTS }

  record Person(long id, String name, Group group, double metric) {}

  record Session(String code, int units, boolean isTech) {}

  record Enrollment(long personId, String sessionCode, double score) {}

  // exceptions

  static class CapacityExceededException extends RuntimeException {
    CapacityExceededException(String msg) { super(msg); }
  }

  static class AlreadyRegisteredException extends RuntimeException {
    AlreadyRegisteredException(String msg) { super(msg); }
  }

  // registry

  static class Registry {
    private final Map<String, Session> sessions = new HashMap<>();
    private final Map<Long, Person> people = new HashMap<>();

    // sessionCode -> set(personId)
    private final Map<String, Set<Long>> sessionToPeople = new HashMap<>();

    // personId -> sessionCode -> score
    private final Map<Long, Map<String, Double>> scores = new HashMap<>();

    // configurable capacity per session
    private final Map<String, Integer> capacityBySession = new HashMap<>();

    public void addSession(Session s, int capacity) {
      sessions.put(s.code(), s);
      capacityBySession.put(s.code(), capacity);
      sessionToPeople.putIfAbsent(s.code(), new HashSet<>());
    }

    public void addPerson(Person p) {
      people.put(p.id(), p);
    }

    public Collection<Person> getPeople() {
      return people.values();
    }

    public Collection<Session> getSessions() {
      return sessions.values();
    }

    public Set<Long> getRegisteredPeople(String sessionCode) {
      return sessionToPeople.getOrDefault(sessionCode, Set.of());
    }

    public void register(String sessionCode, long personId, double score) {
      if (!sessions.containsKey(sessionCode)) {
        throw new IllegalArgumentException("Unknown session: " + sessionCode);
      }
      if (!people.containsKey(personId)) {
        throw new IllegalArgumentException("Unknown person: " + personId);
      }

      Set<Long> registered = sessionToPeople.computeIfAbsent(sessionCode, k -> new HashSet<>());
      int cap = capacityBySession.getOrDefault(sessionCode, Integer.MAX_VALUE);

      if (registered.contains(personId)) {
        throw new AlreadyRegisteredException("Person " + personId + " already registered for " + sessionCode);
      }
      if (registered.size() >= cap) {
        throw new CapacityExceededException("Session " + sessionCode + " is full (capacity=" + cap + ")");
      }

      registered.add(personId);
      scores.computeIfAbsent(personId, k -> new HashMap<>()).put(sessionCode, score);
    }

    // flattened list of all enrollments: (personId, sessionCode, score)
    public List<Enrollment> getAllEnrollments() {
      List<Enrollment> out = new ArrayList<>();
      for (var entry : scores.entrySet()) {
        long personId = entry.getKey();
        for (var sc : entry.getValue().entrySet()) {
          out.add(new Enrollment(personId, sc.getKey(), sc.getValue()));
        }
      }
      return out;
    }

    // group -> sessionCode -> list of personIds
    public Map<Group, Map<String, List<Long>>> getRegisteredIdsByGroupAndSession() {
      return getAllEnrollments().stream()
          .collect(Collectors.groupingBy(
              e -> people.get(e.personId()).group(),
              Collectors.groupingBy(
                  Enrollment::sessionCode,
                  Collectors.mapping(Enrollment::personId, Collectors.toList())
              )
          ));
    }

    // personId -> metric (like "GPA" / skill score / etc.) */
    public Map<Long, Double> getPersonMetrics() {
      return people.values().stream()
          .collect(Collectors.toMap(Person::id, Person::metric, (a, b) -> b));
    }

    // sessionCode -> top N personIds by highest score
    public Map<String, List<Long>> topNIdsByScorePerSession(int n) {
      return getAllEnrollments().stream()
          .collect(Collectors.groupingBy(
              Enrollment::sessionCode,
              Collectors.collectingAndThen(
                  Collectors.toList(),
                  list -> list.stream()
                      .sorted(Comparator.comparingDouble(Enrollment::score).reversed())
                      .limit(n)
                      .map(Enrollment::personId)
                      .toList()
              )
          ));
    }

    public double averageUnitsAllSessions() {
      return sessions.values().stream()
          .mapToInt(Session::units)
          .average()
          .orElse(0.0);
    }

    public double averageUnitsNonTechSessions() {
      return sessions.values().stream()
          .filter(s -> !s.isTech())
          .mapToInt(Session::units)
          .average()
          .orElse(0.0);
    }
  }

  // demo for analytics

  public static void main(String[] args) {
    Registry r = new Registry();

    // sessions
    r.addSession(new Session("S-INTRO-JAVA", 3, true), 3);
    r.addSession(new Session("S-DATA-STRUCT", 4, true), 2);
    r.addSession(new Session("S-COMMUNITY", 2, false), 10);
    r.addSession(new Session("S-WRITING", 3, false), 10);

    // people
    r.addPerson(new Person(1001, "Asha", Group.TECH, 3.8));
    r.addPerson(new Person(1002, "Ben", Group.SCIENCE, 3.6));
    r.addPerson(new Person(1003, "Cleo", Group.ARTS, 3.7));
    r.addPerson(new Person(1004, "Drew", Group.TECH, 3.9));
    r.addPerson(new Person(1005, "Eli", Group.SCIENCE, 3.4));

    // registrations, exceptions and capacity example
    safeRegister(r, "S-INTRO-JAVA", 1001, 91.2);
    safeRegister(r, "S-INTRO-JAVA", 1002, 85.0);
    safeRegister(r, "S-INTRO-JAVA", 1004, 95.5);

    // this one hits capacity (capacity=3)
    safeRegister(r, "S-INTRO-JAVA", 1003, 88.8);

    // duplicate protection
    safeRegister(r, "S-INTRO-JAVA", 1001, 99.9);

    safeRegister(r, "S-DATA-STRUCT", 1004, 98.1);
    safeRegister(r, "S-DATA-STRUCT", 1001, 92.0);
    
    // capacity=2 => will fail
    safeRegister(r, "S-DATA-STRUCT", 1002, 90.0);

    safeRegister(r, "S-COMMUNITY", 1002, 87.0);
    safeRegister(r, "S-COMMUNITY", 1003, 93.0);
    safeRegister(r, "S-WRITING", 1005, 84.5);

    System.out.println("\n=== All Enrollments (personId, session, score) ===");
    r.getAllEnrollments().forEach(System.out::println);

    System.out.println("\n=== Registered IDs by Group and Session ===");
    r.getRegisteredIdsByGroupAndSession()
        .forEach((group, inner) -> {
          System.out.println(group + " ->");
          inner.forEach((session, ids) -> System.out.println("  " + session + ": " + ids));
        });

    System.out.println("\n=== Person Metrics (id -> metric) ===");
    r.getPersonMetrics().forEach((id, metric) -> System.out.println(id + " -> " + metric));

    System.out.println("\n=== Top 2 IDs by Score per Session ===");
    r.topNIdsByScorePerSession(2)
        .forEach((session, ids) -> System.out.println(session + " -> " + ids));

    System.out.println("\n=== Average Units (All Sessions) ===");
    System.out.println(r.averageUnitsAllSessions());

    System.out.println("\n=== Average Units (Non-Tech Sessions) ===");
    System.out.println(r.averageUnitsNonTechSessions());
  }

  private static void safeRegister(Registry r, String sessionCode, long personId, double score) {
    try {
      r.register(sessionCode, personId, score);
    } catch (AlreadyRegisteredException | CapacityExceededException | IllegalArgumentException ex) {
      System.out.println("[register failed] " + ex.getMessage());
    }
  }
}
