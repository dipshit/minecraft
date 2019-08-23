workflow "CI" {
  on = "push"
}

action "Validate yaml" {
  uses = "dipshit/kubeval"
  args = "k8s/*"
}
